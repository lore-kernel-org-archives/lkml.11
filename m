Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6402BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 11:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379685AbiEMLDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 07:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350219AbiEMLDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:03:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 321AF2A1FF2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:03:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B47B143D;
        Fri, 13 May 2022 04:03:21 -0700 (PDT)
Received: from bogus (unknown [10.57.65.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E60B33F5A1;
        Fri, 13 May 2022 04:03:18 -0700 (PDT)
Date:   Fri, 13 May 2022 12:03:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qing Wang <wangqing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] arch_topology: Use llc_id instead of package_id
Message-ID: <20220513110312.wy6g5avs7ngkmhfu@bogus>
References: <20220513083400.343706-1-dietmar.eggemann@arm.com>
 <20220513090330.z25fwthekn4rjkwq@bogus>
 <afafbb0c-5279-bee8-1ef4-434733e2a552@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afafbb0c-5279-bee8-1ef4-434733e2a552@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 12:42:00PM +0200, Dietmar Eggemann wrote:
> On 13/05/2022 11:03, Sudeep Holla wrote:
> > On Fri, May 13, 2022 at 10:34:00AM +0200, Dietmar Eggemann wrote:
>
> [...]
>
> >> @@ -527,7 +528,8 @@ static int __init parse_core(struct device_node *core, int package_id,
> >>  			return -EINVAL;
> >>  		}
> >>
> >> -		cpu_topology[cpu].package_id = package_id;
> >> +		cpu_topology[cpu].package_id = 0;
> >
> > While the above looks good and matches with what I am attempting to do
> > as well ...
> >
> >> +		cpu_topology[cpu].llc_id = llc_id;
> >
> > This looks wrong for simple reason that this is derived incorrectly from
> > the cpu-map while there is no guarantee that it matches the last level
> > cache ID on the system as we didn't parse the cache topology for this.
> > So I disagree with this change as it might conflict with the actual and
> > correct llc_id.
>
> It might not match the LLC, that's true. Something we have already today
> in Android for DynamIQ clusters with big/Little. People using 1. level
> clusters to group CPUs according to uArch.

Not sure if that is the correct representation of h/w cluster on those
platforms, but if they want to misguide OS with the f/w(DT in this case)
well that's their choice.

The main point is we need to get the exact h/w topology information and
then we can decide how to present the below masks as required by the
scheduler for its sched domains.

> My point is we manage to get:
>
> SMT - cpu_smt_mask()
> CLS - cpu_clustergroup_mask()
> MC  - cpu_coregroup_mask()
> DIE - cpu_cpu_mask()
>
> covered in ACPI with the cpu_topology[] structure and if we want CLS on
> DT we have to save cluster_id for the 2. level (DT) cluster.
>

I am not sure on the above point. Even with ACPI PPTT we are just setting
cluster_id based on first or leaf level of the clusters ignoring the
nesting ATM. And that's exactly what I am trying to get with this series[1]


> And that's why I proposed to (ab)use llc_id to form the MC mask.
>

Sure, it is already supported IIUC by cpu_coregroup_mask in arch_topology.c
We just need to make sure llc_id is set correctly in case of DT. Now if
you are saying llc_sibling is not what you need but something else, then
we may need to add that new mask and update cpu_coregroup_mask to choose
that based on certain condition which I believe is bit complicated.

> I'm not currently aware of another solution to get CLS somehow elegantly
> into a DT system.

Will grouping of CPUs into cluster they belong not good enough for CLS ?
I thought that should suffice based on what we have in cpu_clustergroup_mask
(i.e. cluster sibling mask)

--
Regards,
Sudeep
