Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4A7C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 09:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbiCNJKb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiCNJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:10:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497F242A24;
        Mon, 14 Mar 2022 02:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADDC7B80D36;
        Mon, 14 Mar 2022 09:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08154C340E9;
        Mon, 14 Mar 2022 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647248950;
        bh=zx8O5o71LdC5cifVKMEOM1uIXEeT19K3/ICvdk/HAIw=;
        h=From:To:Cc:Subject:Date:From;
        b=TX9eRS8Mdkd+cJ+GIf4dLzQQnALgyUyMfwu/0ccCpOxX/8Rn8FxmPysX5Y6GUazS/
         KzOuqlrZ+aHQYYBaFG7UBrY8ysB2EDPmzXQw2W4Z52oRvPpn5pefCTSbHmzbVpoAJn
         wqnVVEx2xuVL0ZrEAzhg6EBZzFR2XPHKgOkXy2Y+0iqcLPwH0XXHeiFiGhZJuVc9/A
         hUeugpR+rrpQTHg7Fk/7SWlQJMsjvVOxpclb/+Com7QKangHmjP5zBGS8Kj0r1UdnG
         tZYymkUhZ2oQdVhc/unPT20ufJ91/qtfPUIu/DDrI0BokexOO++CVCbpTQX7shRoZM
         Qlo/aPWYr9oJg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, tzungbi@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] platform/chrome: cros_kbd_led_backlight: add EC PWM backend
Date:   Mon, 14 Mar 2022 17:08:30 +0800
Message-Id: <20220314090835.3822093-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds EC PWM as an backend option for ChromeOS keyboard LED
backlight.

The 1st patch reorder the headers alphabetically.

The 2nd patch separates the ACPI backend as an independent option.

The 3rd patch is the DT binding document for the proposed compatible string.

The 4th patch supports OF match.

The 5th patch adds EC PWM as another backend option.

Changes from v1:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220214053646.3088298-1-tzungbi@google.com/)
- Update email address accordingly.

Tzung-Bi Shih (5):
  platform/chrome: cros_kbd_led_backlight: sort headers alphabetically
  platform/chrome: cros_kbd_led_backlight: separate ACPI backend
  dt-bindings: add google,cros-kbd-led-backlight
  platform/chrome: cros_kbd_led_backlight: support OF match
  platform/chrome: cros_kbd_led_backlight: support EC PWM backend

 .../chrome/google,cros-kbd-led-backlight.yaml |  35 +++
 .../bindings/mfd/google,cros-ec.yaml          |   3 +
 drivers/platform/chrome/Kconfig               |  14 +-
 .../platform/chrome/cros_kbd_led_backlight.c  | 220 ++++++++++++++++--
 4 files changed, 249 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-kbd-led-backlight.yaml

-- 
2.35.1.723.g4982287a31-goog

