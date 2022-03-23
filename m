Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AC3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 07:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbiCWHXk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 03:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiCWHXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:23:33 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A348E7305E;
        Wed, 23 Mar 2022 00:22:03 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 386E8100005;
        Wed, 23 Mar 2022 07:21:57 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1nWvJc-009VTW-Gp; Wed, 23 Mar 2022 08:21:56 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     <santoshkumar.yadav@barco.com>, <peter.korsgaard@barco.com>,
        <hdegoede@redhat.com>, <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: Fix duplicate included
 inux/io.h
References: <1648006312-29460-1-git-send-email-baihaowen@meizu.com>
Date:   Wed, 23 Mar 2022 08:21:56 +0100
In-Reply-To: <1648006312-29460-1-git-send-email-baihaowen@meizu.com> (Haowen
        Bai's message of "Wed, 23 Mar 2022 11:31:52 +0800")
Message-ID: <87ils5f817.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Haowen" == Haowen Bai <baihaowen@meizu.com> writes:

 > Clean up the following includecheck warning:
 > drivers/platform/x86/barco-p50-gpio.c: linux/io.h is included more than once.

 > No functional change.

 > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
 > ---
 >  drivers/platform/x86/barco-p50-gpio.c | 1 -
 >  1 file changed, 1 deletion(-)

 > diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/barco-p50-gpio.c
 > index f5c72e3..bb8ed8e 100644
 > --- a/drivers/platform/x86/barco-p50-gpio.c
 > +++ b/drivers/platform/x86/barco-p50-gpio.c
 > @@ -14,7 +14,6 @@
 >  #include <linux/delay.h>
 >  #include <linux/dmi.h>
 >  #include <linux/err.h>
 > -#include <linux/io.h>

It would be nicer to drop the io.h include higher up to keep the
(almost) alphabetical ordering.

Other than that:

Acked-by: Peter Korsgaard <peter.korsgaard@barco.com>

-- 
Bye, Peter Korsgaard
