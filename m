Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C342C43219
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347431AbiDELCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiDEIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:39:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127A65AB;
        Tue,  5 Apr 2022 01:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DD48B81A32;
        Tue,  5 Apr 2022 08:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98332C385A1;
        Tue,  5 Apr 2022 08:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147578;
        bh=aEb6bFctWPFgGqy+PW+9mHUKyTN0aHivpB5iy1Ji954=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIlfP9N74L4Jz9qSwb65AJFPVykXu1j0yWhBWb66apAd3GRKc75HNfa4ZwVw3AlFU
         dzoSE++twcCzcMyVUJThXOAJa492gwDPEYOpiVD9qYv9jV8OfM44Up3UFY9OfRzf/N
         TVsrbLnGqdPnfgMcxclD0CZArslkjZsCaBKx4gJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.16 0047/1017] iio: afe: rescale: use s64 for temporary scale calculations
Date:   Tue,  5 Apr 2022 09:16:00 +0200
Message-Id: <20220405070355.579684664@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <liambeguin@gmail.com>

commit 51593106b608ae4247cc8da928813347da16d025 upstream.

All four scaling coefficients can take signed values.
Make tmp a signed 64-bit integer and switch to div_s64() to preserve
signs during 64-bit divisions.

Fixes: 8b74816b5a9a ("iio: afe: rescale: new driver")
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20220108205319.2046348-5-liambeguin@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/afe/iio-rescale.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -39,7 +39,7 @@ static int rescale_read_raw(struct iio_d
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
-	unsigned long long tmp;
+	s64 tmp;
 	int ret;
 
 	switch (mask) {
@@ -77,10 +77,10 @@ static int rescale_read_raw(struct iio_d
 			*val2 = rescale->denominator;
 			return IIO_VAL_FRACTIONAL;
 		case IIO_VAL_FRACTIONAL_LOG2:
-			tmp = *val * 1000000000LL;
-			do_div(tmp, rescale->denominator);
+			tmp = (s64)*val * 1000000000LL;
+			tmp = div_s64(tmp, rescale->denominator);
 			tmp *= rescale->numerator;
-			do_div(tmp, 1000000000LL);
+			tmp = div_s64(tmp, 1000000000LL);
 			*val = tmp;
 			return ret;
 		default:


