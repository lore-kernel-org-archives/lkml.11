Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7770CC4321E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348600AbiDNOM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244839AbiDNNgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:36:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427EC972B8;
        Thu, 14 Apr 2022 06:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3C9FB82984;
        Thu, 14 Apr 2022 13:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010D9C385A1;
        Thu, 14 Apr 2022 13:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943076;
        bh=lJRGHtvnlnIqTJi4tRsuRxSaNjaLP6TF/agO+h5x2X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnFu4yWCC0/W2nL7E3XWbfHFSZ/ld5V2YCB0rZEefA+e6dbcH+kGAQ3ghyZrMX7kB
         UxROYtRT9AkF7myL0ogo0E3J16mJzs86zM0HPG27XE+hjcliJiPw3ThoE4YMKud7/O
         6JBkz3I1JnCUhz2uTZ52Fe0orsuOt58UikzqcSFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 026/475] iio: inkern: apply consumer scale when no channel scale is available
Date:   Thu, 14 Apr 2022 15:06:51 +0200
Message-Id: <20220414110855.885877658@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <liambeguin@gmail.com>

commit 14b457fdde38de594a4bc4bd9075019319d978da upstream.

When a consumer calls iio_read_channel_processed() and no channel scale
is available, it's assumed that the scale is one and the raw value is
returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.

This for example causes the consumer to process mV when expecting uV.
Make sure to always apply the scaling factor requested by the consumer.

Fixes: adc8ec5ff183 ("iio: inkern: pass through raw values if no scaling")
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20220108205319.2046348-3-liambeguin@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/inkern.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -600,10 +600,10 @@ static int iio_convert_raw_to_processed_
 					IIO_CHAN_INFO_SCALE);
 	if (scale_type < 0) {
 		/*
-		 * Just pass raw values as processed if no scaling is
-		 * available.
+		 * If no channel scaling is available apply consumer scale to
+		 * raw value and return.
 		 */
-		*processed = raw;
+		*processed = raw * scale;
 		return 0;
 	}
 


