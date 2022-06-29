Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818CEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 09:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiF2JLO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 05:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiF2JLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:11:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D357510FF8;
        Wed, 29 Jun 2022 02:11:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D87FA153B;
        Wed, 29 Jun 2022 02:11:09 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15CEB3F792;
        Wed, 29 Jun 2022 02:11:07 -0700 (PDT)
Date:   Wed, 29 Jun 2022 10:09:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: arm/juno: Drop erroneous 'mbox-name' property
Message-ID: <20220629090956.muoonqm3okw5reiu@bogus>
References: <20220610213308.2288094-1-robh@kernel.org>
 <20220628201438.GC694214-robh@kernel.org>
 <CAL_JsqJbZOAMPJDt3ha=rLw0tFuLJ57ZyaCeBJZfEqCHVbtSnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJbZOAMPJDt3ha=rLw0tFuLJ57ZyaCeBJZfEqCHVbtSnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 03:03:03PM -0600, Rob Herring wrote:
> On Tue, Jun 28, 2022 at 2:14 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jun 10, 2022 at 03:33:07PM -0600, Rob Herring wrote:
> > > The 'mbox-name' property in the Juno mailbox node is undocumented and
> > > unused. It's the consumer side of the mailbox binding that have
> > > 'mbox-names' properties.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  arch/arm64/boot/dts/arm/juno-scmi.dtsi | 1 -
> > >  1 file changed, 1 deletion(-)
> >
> > Ping!
> 
> Sorry, I see this was applied. I need to figure out why 'lei' misses
> emails sometimes.

Yes I did apply this and another patch IIRC.

Sorry for naive question what is 'lei' ?

-- 
Regards,
Sudeep
