Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A1DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 11:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiDLLgB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 07:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352848AbiDLLfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:35:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50ABB1AD8F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:14:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 914441570;
        Tue, 12 Apr 2022 03:14:28 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.73.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73E983F5A1;
        Tue, 12 Apr 2022 03:14:27 -0700 (PDT)
Date:   Tue, 12 Apr 2022 11:14:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: Validate single/group leader events
Message-ID: <YlVQ+4R2KZ7Ra0+1@FVFF77S0Q05N>
References: <20220408203330.4014015-1-robh@kernel.org>
 <YlP9KgIZ1PW64tn9@FVFF77S0Q05N>
 <YlQ3q9YFhQU9JsBt@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlQ3q9YFhQU9JsBt@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 09:14:03AM -0500, Rob Herring wrote:
> On Mon, Apr 11, 2022 at 11:04:26AM +0100, Mark Rutland wrote:
> > Hi Rob,
> > 
> > On Fri, Apr 08, 2022 at 03:33:30PM -0500, Rob Herring wrote:
> > > In the case where there is only a cycle counter available (i.e.
> > > PMCR_EL0.N is 0) and an event other than CPU cycles is opened, the open
> > > should fail as the event can never possibly be scheduled. However, the
> > > event validation when an event is opened is skipped when the group
> > > leader is opened. Fix this by always validating the group leader events.
> > > 
> > > Reported-by: Al Grant <al.grant@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > 
> > This looks obviously correct to me, so FWIW:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks.
> 
> > Just to check, have you tested this (e.g. by running on a platform with
> > PMCR_EL0.N == 0, or hacking the PMU probing to report just the cycle counter)
> 
> Yes, tested on FVP with 0 counters running the libperf evsel userspace 
> access tests as that tries both the cycle counter and instruction 
> counts.

Perfect, thanks!

Will, I assume that you'll pick this up.

Mark.
