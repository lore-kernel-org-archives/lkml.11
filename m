Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF04FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 08:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiFBIgk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 04:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiFBIgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:36:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144342A5500
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:36:36 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654158994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=86+6ujTpucV/eIcGsVIsIRZqSvbDV8cw/j/kg0L58OA=;
        b=Qmk3gPWpFlEOLWcZ+hzZ4gW8bh+V/cej71VMTNrvE7KcEv5NZoBBNbbavdLOK/CRrlR5DB
        jJ3byXb6xur986RGa5EUt186R1DhSr5KcLUX5ymJrlo7cGdjjYJipkm1zFsi2/aCtd0n6P
        qcm2FrcAJUsv3yGr2BEZR2n0Z4mzOgkppyPPUarYwEYvhqMFupkjteV+pe3qpJvSVzqJbe
        gYyZeCfbQMBC+Do1X3BDbR1AYhAHKAM/+nUX6sJoBMP/cexUpFKHvwPPD0ws8m+MN0f0/C
        wJy7RLF/hKy5DfyClL0i8vWJJPeDookelumc8fBnqW8xVw41B11lveCx3Nw5wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654158994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=86+6ujTpucV/eIcGsVIsIRZqSvbDV8cw/j/kg0L58OA=;
        b=5fm+5J22TLSenPRbQUrERes9RhqvE6m0F5XbkSFHV1F2NC8fV1RUWqciSa64czdLRPg18s
        jyjXpMogVSizfkCw==
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [printk]  8e27473211: hwsim.ap_ft_pmf_bip_cmac_128.fail
In-Reply-To: <20220602071033.GA27190@xsang-OptiPlex-9020>
References: <20220531033052.GD17663@xsang-OptiPlex-9020>
 <874k15n2jt.fsf@jogness.linutronix.de>
 <20220602071033.GA27190@xsang-OptiPlex-9020>
Date:   Thu, 02 Jun 2022 10:42:34 +0206
Message-ID: <875yljwjfx.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-02, Oliver Sang <oliver.sang@intel.com> wrote:
> we got this test suite from
> https://github.com/bcopeland/wmediumd. there is a detail README there,
> hope it would be helpful to you.

Great, thanks!

> _but_, since you mentioned it's difficult to reproduce, we did more tests,
> and found this could be platform specific.
>
> first, we queued more jobs to platform from which the original report was made,
>
> model: Skylake
> nr_cpu: 4
> memory: 32G
> brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
>
> and confirmed the parent is still clean, and tests still failed on
> 8e27473211

I have located a skylake hardware platform that is similar to this
one. I will try the tests there. Thanks for this information!

John Ogness
