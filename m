Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F69C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 14:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbiGMO66 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiGMO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:58:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D1A8DA2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:58:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 210C71424;
        Wed, 13 Jul 2022 07:58:33 -0700 (PDT)
Received: from bogus (unknown [10.57.7.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4E683F73D;
        Wed, 13 Jul 2022 07:58:29 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:58:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] amba: Remove deferred device addition
Message-ID: <20220713145827.yxeoqj6vmkzhrrpv@bogus>
References: <CGME20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5@eucas1p2.samsung.com>
 <20220705083934.3974140-1-saravanak@google.com>
 <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
 <8a04332e-e7b1-8bc3-d569-5052427bcb13@samsung.com>
 <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:38:33PM -0700, Saravana Kannan wrote:
> Sudeep,
> 
> This makes me think the issue you are seeing is related to your
> hardware drivers. Can you look into those please? I'm leaning towards
> merging this amba clean up and adding delays (say 1ms) to your
> clock/power domain drivers to avoid the crash you are seeing. And then
> you can figure out the actual delays needed and update it.

I haven't got a chance to debug the issue on Juno much further. One thing
about the platform is that we can't turn off the debug power domain that
most of the coresight devices share.

One thing I also observed with -next+this patch is that with a little log
it can access the registers while adding first few devices and then crash
which doesn't align with platform behaviour as we can't turn off the domain
though we attached and turn on in amba_read_periphid and then turn off and
detach the power domain. Ideally if first device amba_read_periphid was
successful, it must be the case for all, but I see different behaviour.

I need to check again to confirm if it is issue with platform power domain
driver. It is based on SCMI so there is some role played by the f/w as well.

--
Regards,
Sudeep
