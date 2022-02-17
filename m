Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FD2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 14:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbiBQOVP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 09:21:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbiBQOVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:21:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E82B1659
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:21:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F2AF2110B;
        Thu, 17 Feb 2022 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645107659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R/dVeNocxw9AeE7KxlwOQ5MLLLTm3H8EST7fSBVZkFk=;
        b=WqOFrNfhJWKi6PcP9yuEUXXLe1HkaQGPTezwCbqbop/prsn/ebfphkKQB1sEnP+iI1eK5c
        dK7H5KjuIaFQ3YaioD8mifOceJNSvw3Z+UYSB8dZoiIRx7zYwRdCaLIzMlu2z/C9MQXAjk
        AZMh9eHvzl+wyZUxqz9kGltBOvWvhfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645107659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R/dVeNocxw9AeE7KxlwOQ5MLLLTm3H8EST7fSBVZkFk=;
        b=afM/9fZq+WCqRHNTe+w7Fh/HLIxyPgvWO6R4L1s2A7OyfaOhoZ2mglbwxTWLSdru+eORLY
        aNAHx4KAJz0CV9BQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 56B95A3B85;
        Thu, 17 Feb 2022 14:20:58 +0000 (UTC)
Date:   Thu, 17 Feb 2022 14:20:56 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] sched/fair: clean up some inconsistent indenting
Message-ID: <20220217142056.GL3301@suse.de>
References: <20220217012818.1177-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220217012818.1177-1-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 09:28:18AM +0800, Yang Li wrote:
> Eliminate the follow smatch warning:
> kernel/sched/fair.c:5661 enqueue_task_fair() warn: inconsistent
> indenting
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

This is a whitespace fix that is more appropriate if modifying the actual
code and fixing the whitspace damage at the same time. Right now, it's
more useful for git blame to point to the commits that made meaningful
changes;

39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list")
304000390f88 ("sched: Cgroup SCHED_IDLE support")

-- 
Mel Gorman
SUSE Labs
