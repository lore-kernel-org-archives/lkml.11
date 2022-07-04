Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD8AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 09:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiGDJBG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 05:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiGDJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:01:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504CAB68
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:01:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y8so5085343eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eT4y52kSDwYMkPDU8vLHO6lBX+TLXBqTTsHP5yCtY4E=;
        b=EX81WfHCP/BD6F7LDKgN3Ep0KJmK0j5vc4tV6khMKraWhUSk4o5JdOKR4bCicwcqtw
         Ss61IYF10DuoTSkxAoabiXlb135pzYxTCywqNh8RSB1b5PxwkUacD732WxP9crcIfKs4
         aRwQugdw2bXbyOnaQrpawGQeslloUT/ph62f+5H7F5sV/TRaCu1aPpqosnPgQCPkVyMa
         DsGLLoEEIP4nUV3U9Di3uYCNC2qSD5+bu5ZIYTL1TWLra33fyG3u1DIOGVuJwQGcjvjE
         WG7+TOEVFb/fdh4DaZjvBusNJ7+NmHIKICqaIhX6jr9CtH3y/YLEAsYACJbU9nyxzyS1
         gVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eT4y52kSDwYMkPDU8vLHO6lBX+TLXBqTTsHP5yCtY4E=;
        b=lE/MnpN1lUwh97AAjdDnX02owBihAaqe0E0D/k08AxJ9DoifGW73rXVY8mDDmt+QBM
         2fjW+jDoIku0c5yXVbEePJaVhnHtSO1xZsW0InqaDU3A+hiPDQBDA+h6oaVMx98KVEt1
         M4sk0UmJ938fM1X/Ir9AzDrVTuQdJCets+BFpiZr4nLVXj7kFaG03dV1DQgB+pZ9tl8z
         29JbmgQVXfV7w3Vd+BTcvx0k5/LbtyzOTZTQ2Cm0Nuj/9IiIx4yp/VI/EWa/YCV4r2CK
         SIQ4IefL928PBCvGl9gHxr0Ql0bfvUSZE3I4F+xtSjm5tpebjar8hDyeBbrT3abOWdwK
         V69w==
X-Gm-Message-State: AJIora9H2fVBsJmPvj+hRoDiit7o4sqDRtIrjpkjNHxdCljpbUnXur9M
        jNOXDnla6bMbBtwq6wLPrzNyAk8XKdR7MA==
X-Google-Smtp-Source: AGRyM1tR4Gd6ADljzwlLPNVZnRjcxbsyTp5XQ4IYBxU0DxmvORlFG+hELY/SzFD35l8NSRG6A216qA==
X-Received: by 2002:a05:6402:348e:b0:435:a912:355f with SMTP id v14-20020a056402348e00b00435a912355fmr35992270edc.326.1656925260815;
        Mon, 04 Jul 2022 02:01:00 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906539500b0072ab9f5ae5fsm1642613ejo.75.2022.07.04.02.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:01:00 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 0/5] mfd: max597x: Add support for max597x
Date:   Mon,  4 Jul 2022 11:00:44 +0200
Message-Id: <20220704090050.3289572-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max597x is multifunction device with hot swap controller, fault
protection & upto four indication leds.

max5978 has single hot swap controller whereas max5970 has two hot swap
controllers.


Marcello Sylvester Bauer (1):
  dt-bindings: mfd: Add bindings for MAX5970 and MAX5978

Patrick Rudolph (4):
  mfd: max597x: Add support for MAX5970 and MAX5978
  regulator: max597x: Add support for max597x regulator
  iio: max597x: Add support for max597x
  leds: max597x: Add support for max597x

 .../devicetree/bindings/mfd/max5970.yaml      | 164 ++++++
 drivers/iio/adc/Kconfig                       |   9 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max597x-iio.c                 | 156 ++++++
 drivers/leds/Kconfig                          |  10 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-max597x.c                   | 130 +++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/max597x.c                         | 109 ++++
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max597x-regulator.c         | 506 ++++++++++++++++++
 include/linux/mfd/max597x.h                   | 100 ++++
 14 files changed, 1211 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml
 create mode 100644 drivers/iio/adc/max597x-iio.c
 create mode 100644 drivers/leds/leds-max597x.c
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 drivers/regulator/max597x-regulator.c
 create mode 100644 include/linux/mfd/max597x.h


base-commit: 88084a3df1672e131ddc1b4e39eeacfd39864acf
-- 
2.35.3

