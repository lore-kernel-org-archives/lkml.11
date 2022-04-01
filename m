Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2106FC433FE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 10:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbiDAKew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344001AbiDAKeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:34:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9EC426E57B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:32:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46D3B13D5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:32:56 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08CA43F66F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:32:55 -0700 (PDT)
Date:   Fri, 1 Apr 2022 11:32:43 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: vexpress/spc: Avoid negative array index when !SMP
Message-ID: <YkbUyzzgsaBwyB+3@e110455-lin.cambridge.arm.com>
References: <20220331190443.851661-1-keescook@chromium.org>
 <YkbFvYRkcXgo3mpK@e110455-lin.cambridge.arm.com>
 <20220401101147.xtweqtftmtwa3txk@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220401101147.xtweqtftmtwa3txk@bogus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 11:11:47AM +0100, Sudeep Holla wrote:
> On Fri, Apr 01, 2022 at 10:28:29AM +0100, Liviu Dudau wrote:
> > On Thu, Mar 31, 2022 at 12:04:43PM -0700, Kees Cook wrote:
> > > When building multi_v7_defconfig+CONFIG_SMP=n, -Warray-bounds exposes
> > > a couple negative array index accesses:
> > > 
> > > arch/arm/mach-vexpress/spc.c: In function 've_spc_clk_init':
> > > arch/arm/mach-vexpress/spc.c:583:21: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
> > >   583 |   if (init_opp_table[cluster])
> > >       |       ~~~~~~~~~~~~~~^~~~~~~~~
> > > arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
> > >   556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
> > >       |       ^~~~~~~~~~~~~~
> > > arch/arm/mach-vexpress/spc.c:592:18: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
> > >   592 |    init_opp_table[cluster] = true;
> > >       |    ~~~~~~~~~~~~~~^~~~~~~~~
> > > arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
> > >   556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
> > >       |       ^~~~~~~~~~~~~~
> > > 
> > > Skip this logic when built !SMP.
> > > 
> > > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> > 
> > Sudeep, can you please take this through your tree for sending it to arm-soc?
> >
> 
> Sure, I will do that as soon as -rc1 is out.

Cheers, much appreciated!

Best regards,
Liviu

> 
> -- 
> Regards,
> Sudeep

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
