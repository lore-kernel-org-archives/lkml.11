Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB26C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 00:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiFBAbP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiFBAbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 20:31:13 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF1D29B12B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 17:31:10 -0700 (PDT)
Date:   Wed, 1 Jun 2022 17:31:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654129868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qp+wb8ntoYKonlACt1dWRVIscCiQhmJA/jSAIppfpWc=;
        b=PwmGWr5SGjizofp8OH+1vXp8YX4tsSjWP8krwRrDurlPT8Vbt0j5uKOPcDwu/2R1K9RlmC
        gHlfdKfRV7NHBaAiFuOEmCEb1cTxxdjYViR1ybbTAgu3DCbAnt7jPzMzkI0XRrpwLAzq/+
        AhdrHDH87NE+qwokhsRgAmqaTbzsyuM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v5 2/6] mm: shrinkers: introduce debugfs interface for
 memory shrinkers
Message-ID: <YpgEx2srp5ipTbe6@carbon>
References: <20220601032227.4076670-1-roman.gushchin@linux.dev>
 <20220601032227.4076670-3-roman.gushchin@linux.dev>
 <20220601142358.75a6c9c5d4a988bd58667717@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601142358.75a6c9c5d4a988bd58667717@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:23:58PM -0700, Andrew Morton wrote:
> On Tue, 31 May 2022 20:22:23 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
> > This commit introduces the /sys/kernel/debug/shrinker debugfs
> > interface
> 
> Should it be at the top level?  Maybe /sys/kernel/debug/vm/shrinker
> would be more future-safe. (or .../mm/...)

There are already some top-level mm-related items (slab, zswap, extfrag, etc)
and I don't think there will be non-mm shrinkers in the kernel (given that
it's a kernel-wide API).

But no strong opinion here, if you strongly prefer mm/ or vm/, I'm happy
to change it.

Thanks!
