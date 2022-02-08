Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB3EC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 11:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357031AbiBHLZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356083AbiBHKIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:08:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED40DC03FEC0;
        Tue,  8 Feb 2022 02:08:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 76BA61F388;
        Tue,  8 Feb 2022 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644314900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePNInOzC6B5yJASGd/cwztAJV06U48l5tV+fyrVP+Cs=;
        b=UUqjWtY9SCXAhFmVatTniPu2rGbqj9soOjeMqZZUKgqY0wGYEx99UAcgCBeWBfXuqinAUR
        CuI6xMeqwBDeZyaUWLf68hyGwMFwu0aZZSiHHYuq5MyqmyaTx8PSttFuah16OymkTYBciv
        2ub3JHIEYPTnLJ9em/aYA989OP2dRbY=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 07731A3B87;
        Tue,  8 Feb 2022 10:08:20 +0000 (UTC)
Date:   Tue, 8 Feb 2022 11:08:18 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v4 1/4] lib/vsprintf: Avoid redundant work with 0 size
Message-ID: <YgJBEgYUuu/b8ZER@alley>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220202203036.744010-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202203036.744010-2-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-02-02 15:30:33, Waiman Long wrote:
> For *scnprintf(), vsnprintf() is always called even if the input size is
> 0. That is a waste of time, so just return 0 in this case.
> 
> Note that vsnprintf() will never return -1 to indicate an error. So
> skipping the call to vsnprintf() when size is 0 will have no functional
> impact at all.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
