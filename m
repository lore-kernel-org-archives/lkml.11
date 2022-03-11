Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DC4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 02:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbiCKCk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiCKCkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:40:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA1A119F39
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:39:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0825460B06
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDE7C340EB;
        Fri, 11 Mar 2022 02:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646966392;
        bh=EZlhFHY/Jt1mxxpZeR8oroVr47JrSXbcK5pFtBd5k50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QlsrF9K3VcIwclEe9QUJWTvJuXuX/4qPJoTKdPKI4SAj6cBV1Rr6asZ17SMII4AhB
         qSV+h7D7X6j/NoLreUHUhTFWhMZmRe18pKDbWi4wEq7j0Wpru8ZE5RbtriwABoFZ3e
         K1qcqbF9nqyTUir0olDajk71uA3TIc6kPh2aInIs=
Date:   Thu, 10 Mar 2022 18:39:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
Message-Id: <20220310183951.cb713c6ae926ea6ea8489a71@linux-foundation.org>
In-Reply-To: <20220310120749.23077-1-osalvador@suse.de>
References: <20220310120749.23077-1-osalvador@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 13:07:49 +0100 Oscar Salvador <osalvador@suse.de> wrote:

> Abhishek reported that after patch [1], hotplug operations are
> taking ~double the expected time. [2]
> 
> The reason behind is that the CPU callbacks that migrate_on_reclaim_init()
> sets always call set_migration_target_nodes() whenever a CPU is brought
> up/down.
> But we only care about numa nodes going from having cpus to become
> cpuless, and vice versa, as that influences the demotion_target order.
> 
> We do already have two CPU callbacks (vmstat_cpu_online() and vmstat_cpu_dead())
> that check exactly that, so get rid of the CPU callbacks in
> migrate_on_reclaim_init() and only call set_migration_target_nodes() from
> vmstat_cpu_{dead,online}() whenever a numa node change its N_CPU state.

What I'm not getting here (as so often happens) is a sense of how badly
this affects our users.  Does anyone actually hotplug frequently enough
to care?

If "yes" then I'm inclined to merge this up for 5.18 with a cc:stable. 
Not for 5.17 because it's late and things are looking rather creaky
already.

And I'll add a

Fixes: 884a6e5d1f93b ("mm/migrate: update node demotion order on hotplug events")

which is that patch's fourth such bouquet.
