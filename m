Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388E9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 14:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245266AbiEJOPP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 10:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245292AbiEJNre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:47:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D7C4E3BC;
        Tue, 10 May 2022 06:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 17414CE1EE2;
        Tue, 10 May 2022 13:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ECCC385C2;
        Tue, 10 May 2022 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652189737;
        bh=oXK+xeO7TyS/609kqkxla+MZL2jQ1JRBvy7n7RIohAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B95FaSPXmDw/EfQ2RfrRH+fkUr+iyn/wlxrYkN+BKIduDBfVramYI3FAnWqdgCY94
         aceCh/IiKmtJdgVnL5vrJootonoOnOaU2WdFBDu3JbCbLAwfmc7La5nkGFeZGCPdZS
         CyQH/2MVqHPZQCLV3KnpgStGkkyhFxUFYcAbHTbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrei Lalaev <andrei.lalaev@emlid.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 5.17 013/140] gpiolib: of: fix bounds check for gpio-reserved-ranges
Date:   Tue, 10 May 2022 15:06:43 +0200
Message-Id: <20220510130741.986726495@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510130741.600270947@linuxfoundation.org>
References: <20220510130741.600270947@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Lalaev <andrei.lalaev@emlid.com>

commit e75f88efac05bf4e107e4171d8db6d8c3937252d upstream.

Gpiolib interprets the elements of "gpio-reserved-ranges" as "start,size"
because it clears "size" bits starting from the "start" bit in the according
bitmap. So it has to use "greater" instead of "greater or equal" when performs
bounds check to make sure that GPIOs are in the available range.
Previous implementation skipped ranges that include the last GPIO in
the range.

I wrote the mail to the maintainers
(https://lore.kernel.org/linux-gpio/20220412115554.159435-1-andrei.lalaev@emlid.com/T/#u)
of the questioned DTSes (because I couldn't understand how the maintainers
interpreted this property), but I haven't received a response.
Since the questioned DTSes use "gpio-reserved-ranges = <0 4>"
(i.e., the beginning of the range), this patch doesn't affect these DTSes at all.
TBH this patch doesn't break any existing DTSes because none of them
reserve gpios at the end of range.

Fixes: 726cb3ba4969 ("gpiolib: Support 'gpio-reserved-ranges' property")
Signed-off-by: Andrei Lalaev <andrei.lalaev@emlid.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-of.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -912,7 +912,7 @@ static void of_gpiochip_init_valid_mask(
 					   i, &start);
 		of_property_read_u32_index(np, "gpio-reserved-ranges",
 					   i + 1, &count);
-		if (start >= chip->ngpio || start + count >= chip->ngpio)
+		if (start >= chip->ngpio || start + count > chip->ngpio)
 			continue;
 
 		bitmap_clear(chip->valid_mask, start, count);


