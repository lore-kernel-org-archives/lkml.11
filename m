Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F090ECAAD5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 23:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiH3XRL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiH3XQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:16:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7181C65817
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:18 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id c4so10597271iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1cUv8OQqQzL2mBMn36W85TxKKM2bLkDxJLwZ9X/W2YQ=;
        b=n8CbHCFCLa3NvlMNU6GyEavHcWEz+keNd9w4QE9X/dGEtMIwWBrhzek4sWMS/9Mra5
         7mog0q8D4QWNT3dJ2mn2GkEkOgxk+S9uRjAqmpEn14RFrL8Tlv2FVGhR1aRmq7TQssWN
         GcYrY4tRT/1uoMpxqA0BmqO9JxkI5fCH44cGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1cUv8OQqQzL2mBMn36W85TxKKM2bLkDxJLwZ9X/W2YQ=;
        b=AOfTKjn3zrm3GDqZzNKnYenDn/D2Q830M7s3YZ4CuUawHGGP7diak1QeY/tiv4O/hI
         WjPYqxh+mKq9XgZEZv00FPHWFb5B8Barave0PYbCM5yQtRf4wibld/wpzX2kwi4/Si2s
         UIWzhcsHvRMpG5hwzGE8EMY/BE1NfBu8Ip6miwmo7X1AGRk25LirW+sEqQD7xCMtIkyH
         dkysVF6YT7QUAc0lFyybP8iURh1cgMrKw5ZWqCxIkB/QMRQnhzi9MqU33rV0tBFjLZJX
         93dS99mB6RBMJPe8+5kVxFiNMO4/aPVfCFZuwi2YBnmm/fC/j/4sAvBBu8PWD05/jlVy
         /oCw==
X-Gm-Message-State: ACgBeo3CAPV6P5leLr/PjaxpGH6ftFLtMp1F0zyetuVbETT22vLbQHXz
        VT6g5z1O+Q1pBkhzOaN3fUriLw==
X-Google-Smtp-Source: AA6agR7PjXZLt8Hb1gIOgXE8wv+NOkD4UEFuOUmbIEpKHV8192AELOhphNFTR6UEXBQm62sSsoK5uw==
X-Received: by 2002:a02:860d:0:b0:345:b478:a611 with SMTP id e13-20020a02860d000000b00345b478a611mr13376735jai.95.1661901377952;
        Tue, 30 Aug 2022 16:16:17 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id z30-20020a056602081e00b0068b1858c81asm6165821iow.13.2022.08.30.16.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 16:16:17 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     hdegoede@redhat.com, mario.limonciello@amd.com, timvp@google.com,
        rafael@kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Alistair Francis <alistair@alistair23.me>,
        Angela Czubak <acz@semihalf.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] HID: i2c-hid: Don't set wake_irq when using ACPI
Date:   Tue, 30 Aug 2022 17:15:40 -0600
Message-Id: <20220830171332.7.Id22d056440953134d8e8fe2c2aff79c79bc78424@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220830231541.1135813-1-rrangel@chromium.org>
References: <20220830231541.1135813-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-core will now handle setting the wake_irq for ACPI systems.

I didn't delete the whole block since this also covers systems that
don't use ACPI or DT, but I'm honestly not sure if that's a valid
config.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/hid/i2c-hid/i2c-hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 0b7a1a8b3e9a33..630e8dcda1100d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1037,10 +1037,10 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 		goto err_powered;
 
 	/*
-	 * Systems using device tree should set up wakeup via DTS,
+	 * Systems using device tree should set up wakeup via DTS or ACPI,
 	 * the rest will configure device as wakeup source by default.
 	 */
-	if (!client->dev.of_node) {
+	if (!client->dev.of_node && !has_acpi_companion(&client->dev)) {
 		device_init_wakeup(&client->dev, true);
 		dev_pm_set_wake_irq(&client->dev, client->irq);
 	}
-- 
2.37.2.672.g94769d06f0-goog

