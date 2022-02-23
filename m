Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7B7C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 19:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbiBWTcQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 14:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbiBWTcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:32:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 762E46311;
        Wed, 23 Feb 2022 11:31:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A84B8ED1;
        Wed, 23 Feb 2022 11:31:42 -0800 (PST)
Received: from bogus (unknown [10.57.3.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05E953F66F;
        Wed, 23 Feb 2022 11:31:39 -0800 (PST)
Date:   Wed, 23 Feb 2022 19:30:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] PM: cpu: Add CPU_LAST_PM_ENTER and
 CPU_FIRST_PM_EXIT support
Message-ID: <20220223193050.y7parhlmnspcyom3@bogus>
References: <20220223125536.230224-1-shawn.guo@linaro.org>
 <20220223125536.230224-2-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223125536.230224-2-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 08:55:34PM +0800, Shawn Guo wrote:
> It becomes a common situation on some platforms that certain hardware
> setup needs to be done on the last standing cpu, and rpmh-rsc[1] is such
> an existing example.  As figuring out the last standing cpu is really
> something generic, it adds CPU_LAST_PM_ENTER (and CPU_FIRST_PM_EXIT)
> event support to cpu_pm helper, so that individual driver can be
> notified when the last standing cpu is about to enter low power state.

Sorry for not getting back on the previous email thread.
When I meant I didn't want to use CPU_CLUSTER_PM_{ENTER,EXIT}, I wasn't
thinking new ones to be added as alternative. With this OSI cpuidle, we
have introduces the concept of power domains and I was check if we can
associate these requirements to them rather than introducing the first
and last cpu notion. The power domains already identify them in order
to turn on or off. Not sure if there is any notification mechanism in
genpd/power domains. I really don't like this addition. It is disintegrating
all the solutions for OSI and makes it hard to understand.

One solution I can think of(not sure if others like or if that is feasible)
is to create a parent power domain that encloses all the last level CPU
power domains, which means when the last one is getting powered off, you
will be asked to power off and you can take whatever action you want.

--
Regards,
Sudeep
