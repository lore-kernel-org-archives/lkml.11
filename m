Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8653C3F6B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 10:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356608AbiHWKzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356022AbiHWKsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:48:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7A4AB071;
        Tue, 23 Aug 2022 02:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A856FB81C35;
        Tue, 23 Aug 2022 09:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2763C433C1;
        Tue, 23 Aug 2022 09:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661245935;
        bh=fdew62UuZcMsFie8kfqEEAZhB9kWdQ/7hAK9yJC/+Ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2DBiOyFg0knnZEjNxY7U9hANBzsWwwiHWnNFJmDYvd5eUaGcBo8j0/e5jIEOqqmt
         MCfzQUPK7kDmk+zCT8QdMgF7zJ3ChhkkR4PbzskeUJesXtRKJRem2LhOX/xLJE/Lx0
         Z8yFa7eQVQb8qhzxXhZm600SQIaCrG+rZXkJQkbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.19 235/287] pinctrl: qcom: msm8916: Allow CAMSS GP clocks to be muxed
Date:   Tue, 23 Aug 2022 10:26:44 +0200
Message-Id: <20220823080108.953157961@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080100.268827165@linuxfoundation.org>
References: <20220823080100.268827165@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Travkin <nikita@trvn.ru>

commit 44339391c666e46cba522d19c65a6ad1071c68b7 upstream.

GPIO 31, 32 can be muxed to GCC_CAMSS_GP(1,2)_CLK respectively but the
function was never assigned to the pingroup (even though the function
exists already).

Add this mode to the related pins.

Fixes: 5373a2c5abb6 ("pinctrl: qcom: Add msm8916 pinctrl driver")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
Link: https://lore.kernel.org/r/20220612145955.385787-4-nikita@trvn.ru
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/qcom/pinctrl-msm8916.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pinctrl/qcom/pinctrl-msm8916.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8916.c
@@ -852,8 +852,8 @@ static const struct msm_pingroup msm8916
 	PINGROUP(28, pwr_modem_enabled_a, NA, NA, NA, NA, NA, qdss_tracedata_b, NA, atest_combodac),
 	PINGROUP(29, cci_i2c, NA, NA, NA, NA, NA, qdss_tracedata_b, NA, atest_combodac),
 	PINGROUP(30, cci_i2c, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),
-	PINGROUP(31, cci_timer0, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(32, cci_timer1, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(31, cci_timer0, flash_strobe, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(32, cci_timer1, flash_strobe, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(33, cci_async, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),
 	PINGROUP(34, pwr_nav_enabled_a, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),
 	PINGROUP(35, pwr_crypto_enabled_a, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),


