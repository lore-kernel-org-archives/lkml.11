Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BDCCCA473
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiF0L1o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiF0L0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:26:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416DC65D8;
        Mon, 27 Jun 2022 04:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01274B8111B;
        Mon, 27 Jun 2022 11:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6903DC3411D;
        Mon, 27 Jun 2022 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656329190;
        bh=4viCvBWNjlVqiYuJe3YQwX6lDbcoBs/EOvALTfDMLeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZKhFD5AReQKoaUheQMbbyJ0o5Kv3CCySAXeEEpn5SG6UqaM/RHZfXmSj1B4u3RAJ
         Qjyq4UyN19u69aOUZrSBySnB54+3g2DkQftdW8SUVhp6epq4iCEn4sogho4RLVU6x9
         BCIM3osiovQQSyIRaLD6IPzVHJfx/PcwsM0eFKe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10 079/102] iio: adc: stm32: fix maximum clock rate for stm32mp15x
Date:   Mon, 27 Jun 2022 13:21:30 +0200
Message-Id: <20220627111935.812598474@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111933.455024953@linuxfoundation.org>
References: <20220627111933.455024953@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Moysan <olivier.moysan@foss.st.com>

commit 990539486e7e311fb5dab1bf4d85d1a8973ae644 upstream.

Change maximum STM32 ADC input clock rate to 36MHz, as specified
in STM32MP15x datasheets.

Fixes: d58c67d1d851 ("iio: adc: stm32-adc: add support for STM32MP1")
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Link: https://lore.kernel.org/r/20220609095234.375925-1-olivier.moysan@foss.st.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/stm32-adc-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -797,7 +797,7 @@ static const struct stm32_adc_priv_cfg s
 static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
 	.regs = &stm32h7_adc_common_regs,
 	.clk_sel = stm32h7_adc_clk_sel,
-	.max_clk_rate_hz = 40000000,
+	.max_clk_rate_hz = 36000000,
 	.has_syscfg = HAS_VBOOSTER | HAS_ANASWVDD,
 	.num_irqs = 2,
 };


