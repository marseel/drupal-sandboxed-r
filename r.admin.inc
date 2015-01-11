<?php

/**
 * @file
 * Maxima admin file for validating and specifying form R paths
 *

/**
 * Form API callback to validate the upload settings form.
 */
function r_admin_settings_validate($form, &$form_state) {

  $path1 = file_exists($form_state['values']['r_path']);

  if (!$path1) {
    form_set_error('r_path', t('R binary  not found.'));
  }

}

/**
 * Menu callback for the upload settings form.
 */
function r_admin_settings($form, &$form_state) {

  $form['settings_general'] = array(
    '#type' => 'fieldset',
    '#title' => t('Settings'),
    '#collapsible' => TRUE,
  );
  $form['settings_general']['r_path'] = array(
    '#type' => 'textfield',
    '#title' => t('Path to R binary'),
    '#default_value' => check_plain(variable_get('r_path', '/usr/bin/R')),
    '#size' => 50,
    '#maxlength' => 50,
    '#description' => t('Absolute path to the R binary.'),
    '#field_suffix' => t(''),
  );

  $form['settings_general']['tmp_path'] = array(
    '#type' => 'textfield',
    '#title' => t('temporary files path'),
    '#default_value' => check_plain(variable_get('r_tmp', '/tmp')),
    '#size' => '50',
    '#maxlength' => '150',
    '#description' => t('Absolute path to tmp directory.'),
  );

  $form['settings_general']['cache_path'] = array(
    '#type' => 'textfield',
    '#title' => t('Cache Path'),
    '#default_value' => check_plain(variable_get('r_cache', '/tmp')),
    '#size' => '50',
    '#maxlength' => '150',
    '#description' => t('Absolute path to cache directory.'),
  );

  $form['settings_general']['r_mode'] = array(
    '#type' => 'checkbox',
    '#title' => t('Minimal R mode'),
    '#default_value' => variable_get('r_mode', 0),
    '#description' => t('Run R in most silent (--slave) mode with minimal output.  Flush caches after changing to reset any cached output.'),
  );

  $form['#validate'][] = 'r_admin_settings_validate';

  return system_settings_form($form);
}

