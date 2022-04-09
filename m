Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA12C433FE
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Apr 2022 20:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiDIUHR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Apr 2022 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiDIUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:07:07 -0400
X-Greylist: delayed 536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Apr 2022 13:04:58 PDT
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4894347ACF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:04:57 -0700 (PDT)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eaf9:8401:9d41:ea18:e395:a08d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id B797F2C4651;
        Sat,  9 Apr 2022 21:55:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1649534159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fMt4I03fckGtsX2/5HHKBEwvVYqJZXnkDuuqWm27wEs=;
        b=OSXfGRy2N5kkPfOKdItrH1TEeI6lv1xTKZj/D08SA2jliplPYh112/KBxzMWri0inMCTQy
        rGptRAEXfhyvBzxbAXrYeGwN3VaTtXvNwVFXtIPR1BpM9c9jiP+kslZ8BC7gGJODaznmva
        twjdB2NeTjiMtW91a5batGmXg6IYDYFVSEINquAG8yaQQZcFQITv046odE5SaxeHw+Dhhj
        BMipFs3fFoFb0rqf84S38R9JIdhmLt+TSUf6cumAF6tl4z0Mk33bF5WvKinLcKiAZGFbXk
        QW/jVZOR7opkme1M8xkDAbFLliI6UBn7QgTNqLQhzeaAurdrJofdMfV0DCHa/A==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] Support for RTL930x/RTL931x GPIOs
Date:   Sat,  9 Apr 2022 21:55:45 +0200
Message-Id: <cover.1649533972.git.sander@svanheule.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the GPIO controllers as found on the
RTL930x and RTL931x SoC families of MIPS CPUs, used in managed NBase-T
ethernet switches.

The RTL931x's GPIO controller behaves the same as the one in the older
RTL838x and RTL839x series. This controller is trivially supported.

The RTL930x's controller has a reversed port order, and supports CPU
affinity settings for individual GPIO line IRQs, thus requiring two
additional changes to implement these features.

Sander Vanheule (6):
  dt-bindings: gpio: realtek-otto: Add rtl9300 compatible
  gpio: realtek-otto: Support reversed port layouts
  gpio: realtek-otto: Support per-cpu interrupts
  gpio: realtek-otto: Add RTL930x support
  dt-bindings: gpio: realtek-otto: Add rtl9310 compatible
  gpio: realtek-otto: Add RTL931x support

 .../bindings/gpio/realtek,otto-gpio.yaml      |  34 ++++-
 drivers/gpio/gpio-realtek-otto.c              | 137 +++++++++++++++++-
 2 files changed, 164 insertions(+), 7 deletions(-)

-- 
2.35.1

