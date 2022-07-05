Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29C3C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 20:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiGEUIz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiGEUIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:08:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B4F0192BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 13:08:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A3E1152B;
        Tue,  5 Jul 2022 13:08:51 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 030783F70D;
        Tue,  5 Jul 2022 13:08:47 -0700 (PDT)
Date:   Tue, 5 Jul 2022 21:07:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     Brice.Goglin@inria.fr, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Valentina.FernandezAlanis@microchip.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wangqing@vivo.com, robh+dt@kernel.org, rafael@kernel.org,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@esmil.dk
Subject: Re: [PATCH v6 00/21] arch_topology: Updates to add socket support
 and fix cluster ids
Message-ID: <20220705200737.unxj2hdcowdjdkt2@bogus>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
 <6a647b6b-c913-b9d7-a23e-b17a8034c5c8@microchip.com>
 <507c6b64-fc23-3eea-e4c1-4d426025d658@inria.fr>
 <da1cf1aa-7291-92cd-4b62-0af0d0d12277@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1cf1aa-7291-92cd-4b62-0af0d0d12277@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 07:06:17PM +0000, Conor.Dooley@microchip.com wrote:
> [Adding back the CC list from the original thread]
> 
> On 05/07/2022 13:27, Brice Goglin wrote:
> > [You don't often get email from brice.goglin@inria.fr. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hello Conor
> > 
> > I am the main developer of hwloc [1] which is used by many people to
> > detect the topology of servers. We're started to see some users of hwloc
> > on RISC-V and we got some reports about the topology exposed by
> > Linux/sysfs being wrong on some platforms.
> > 
> > For instance https://github.com/open-mpi/hwloc/issues/536 says HiFive
> > Unmatched with SiFive Freedom U740 running Linux 5.15 exposes a single
> > core with 4 threads instead of 4 cores, while StarFive VisionFive v1
> > with JH7100 running 5.18.5 correctly exposes 2 cores.
> 
> And with Sudeep's patches applied I get (next-20220704):
> # hwloc-calc -N core all
> 1
> # hwloc-calc -N pu all
> 4
> On a PolarFire SoC (so the same as a SiFive U540).
> So unfortunately, these patches are not the fix you seek!
>

Not sure what you mean by that ?

> Wracked my brains for a bit, but could not see any differences
> between the U740 and the JH7100. Culprit seems to be the lack
> of a cpu-map node (which is only present in the downstream dt).
>

Indeed, the topology depends on /cpu-map node. However on ARM64 we do
have fallback settings in absence of /cpu-map node so that it is handled
correctly. I wasn't sure what was or can be done on RISC-V as /cpu-map
is optional.

> I've sent patches for the upstream devicetrees:
> https://lore.kernel.org/linux-riscv/20220705190435.1790466-1-mail@conchuod.ie/
>

I will take a look.

> > Does it depend a lot on the platform because
> > device-tree and/or ACPI aren't always properly filled by vendors?

Absolutely.

> > Does it depend a lot on the Linux kernel version?

Ideally not much, but hey we had some issues on Arm64 too which this series
is addressing.

> > Should I expect significant improvements for both in the next months?

Not much in topology or nothing planned. I have no idea on NUMA


Hi Conor,

I would have preferred you to add me to the original thread and referred
this thread from there. I don't want to derail the discussion in this
thread as nothing much can be done here.

--
Regards,
Sudeep
