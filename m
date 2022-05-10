Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 14:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbiEJOzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 10:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbiEJOzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B43496AA;
        Tue, 10 May 2022 07:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAAC061679;
        Tue, 10 May 2022 14:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728F2C385C9;
        Tue, 10 May 2022 14:16:01 +0000 (UTC)
Date:   Tue, 10 May 2022 10:16:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@redhat.com>,
        kbuild-all@lists.01.org, Shakeel Butt <shakeelb@google.com>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH] percpu: improve percpu_alloc_percpu event trace
Message-ID: <20220510101600.48529d5e@gandalf.local.home>
In-Reply-To: <6e68298c-7cdd-9984-215e-7e6fb3d03fe8@openvz.org>
References: <8d627f02-183f-c4e7-7c15-77b2b438536b@openvz.org>
        <202205070420.aAhuqpYk-lkp@intel.com>
        <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
        <20220509170605.2eb7637e@gandalf.local.home>
        <6e68298c-7cdd-9984-215e-7e6fb3d03fe8@openvz.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 07:22:02 +0300
Vasily Averin <vvs@openvz.org> wrote:

> ... and when  __def_gfpflag_names() traslates them to unsigned long
> 
>        {(unsigned long)GFP_DMA,                "GFP_DMA"},             \
>        {(unsigned long)__GFP_HIGHMEM,          "__GFP_HIGHMEM"},       \
>        {(unsigned long)GFP_DMA32,              "GFP_DMA32"},           \
> 
> ... it leads to sparse warnings bacuse type gfp_t was declared as 'bitwise'

Ah' it's the printing of the flag bits. Got it.

-- Steve
