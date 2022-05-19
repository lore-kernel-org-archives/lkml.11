Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E71EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 16:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbiESQdE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 12:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbiESQdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:33:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF468304
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9CF461CAC;
        Thu, 19 May 2022 16:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE9BC385AA;
        Thu, 19 May 2022 16:32:57 +0000 (UTC)
Date:   Thu, 19 May 2022 12:32:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     YoPOhRctb8wwbmY5@carbon, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3] tracing: add 'accounted' entry into output of
 allocation tracepoints
Message-ID: <20220519123255.543b8db6@gandalf.local.home>
In-Reply-To: <e018be81-f4f2-a26f-7c5a-7adddd9c56c4@openvz.org>
References: <f6625cd8-90f9-6d48-50f6-7bb052bf479f@openvz.org>
        <20220518160447.20a7b96f@gandalf.local.home>
        <b728f944-e3ae-cdb6-5f02-2fb21466b2fb@openvz.org>
        <20220519100348.101d027d@gandalf.local.home>
        <e018be81-f4f2-a26f-7c5a-7adddd9c56c4@openvz.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 19:29:36 +0300
Vasily Averin <vvs@openvz.org> wrote:

> Frankly speaking I vote for performance with both hands.
> However I'm still would like to avoid new sparse warnings.
> Christoph Hellwig just recently taught me, "never add '__force' before
> thinking hard about them", but in this case I would need to use it three times.
> 
> I found that bitwise typecasts can be avoided by using translation unions. 
> 
> What do you think about following trick?

It's really up to you memory management folks. Although I may need to
update libtraceevent to handle the union case. That may be a bit tricky.

-- Steve
