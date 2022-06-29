Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C661AC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 18:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiF2SfI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 14:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiF2SfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:35:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63448381B7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:35:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6316E1480;
        Wed, 29 Jun 2022 11:35:02 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E91213F5A1;
        Wed, 29 Jun 2022 11:34:59 -0700 (PDT)
Date:   Wed, 29 Jun 2022 19:33:48 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        atishp@atishpatra.org, atishp@rivosinc.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wangqing@vivo.com, robh+dt@kernel.org, rafael@kernel.org,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, gshan@redhat.com,
        Valentina.FernandezAlanis@microchip.com
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Message-ID: <20220629183348.ga7gbcsba57dzf2t@bogus>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
 <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
 <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 06:18:25PM +0000, Conor.Dooley@microchip.com wrote:
> On 29/06/2022 18:49, Conor.Dooley@microchip.com wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 27/06/2022 17:50, Sudeep Holla wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> The cacheinfo is now initialised early along with the CPU topology
> >> initialisation. Instead of relying on the LLC ID information parsed
> >> separately only with ACPI PPTT elsewhere, migrate to use the similar
> >> information from the cacheinfo.
> >>
> >> This is generic for both DT and ACPI systems. The ACPI LLC ID information
> >> parsed separately can now be removed from arch specific code.
> > 
> > Hey Sudeep,
> > I bisected broken boot on PolarFire SoC to this patch in next-20220629 :/
> > I suspect the issue is a missing "next-level-cache" in the the dt:
> > arch/riscv/boot/dts/microchip/mpfs.dtsi
> > 
> > Adding next-level-cache = <&cctrllr> fixes the boot.
>

If the above is missing, even the existing cacheinfo will be incorrect on
that system. But we must end up with L1 as LLC, I need to check if that
breaks the boot.

> No, no it doesn't. Not sure what I was thinking there.
> Prob tested that on the the last commit that bisect tested
> rather than the one it pointed out the problem was with.
>

So can I assume the pointed commit is where the boot breaks ?

> Either way, boot is broken in -next.
>

OK, that's bad. 

> > Not sure what the resolution here is, old devicetrees are meant to keep
> > booting, right?
> >

Ideally yes. But with this, I assume the cacheinfo to userspace is also broken
on this platform and I guess that needs fixing which can happen with DT update
only.

--
Regards,
Sudeep
