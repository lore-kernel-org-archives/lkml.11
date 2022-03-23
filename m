Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4A6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 08:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242446AbiCWIKO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242447AbiCWIKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:10:09 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF01074DE0;
        Wed, 23 Mar 2022 01:08:38 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DB4AFFF80A;
        Wed, 23 Mar 2022 08:08:35 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1nWw2k-009WST-El; Wed, 23 Mar 2022 09:08:34 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     <santoshkumar.yadav@barco.com>, <peter.korsgaard@barco.com>,
        <hdegoede@redhat.com>, <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] platform/x86: barco-p50-gpio: Fix duplicate included
 inux/io.h
References: <1648021825-6182-1-git-send-email-baihaowen@meizu.com>
Date:   Wed, 23 Mar 2022 09:08:34 +0100
In-Reply-To: <1648021825-6182-1-git-send-email-baihaowen@meizu.com> (Haowen
        Bai's message of "Wed, 23 Mar 2022 15:50:25 +0800")
Message-ID: <87ee2tf5vh.fsf@dell.be.48ers.dk>
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
 V1-> V2: drop the io.h include higher up to keep the (almost) alphabetical ordering.

Acked-by: Peter Korsgaard <peter.korsgaard@barco.com>

-- 
Bye, Peter Korsgaard
