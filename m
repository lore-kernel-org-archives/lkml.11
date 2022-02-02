Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA06EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Feb 2022 14:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345063AbiBBOpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiBBOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:45:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9876C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zCS0xrA163LrWKKod/qW1i1A5aFwglNYqiR5hYaaFUk=; b=jrhJfASq3CsQc+l41MDvpWNWKs
        nid/U/ydq2D2e+DYYY9/tblIHMdaI9+Ydt1P9SjptezZI0XaquBbMIxKzs4fTSg908LdeZJ1bK94e
        l9zvJ5sj5VrWF1C/OZNa0GPN4iCo9B8+G9tATTK79JsCH68x4uqGZpCwgoOxIgrH359bBD0dsuJAd
        7HCd/v3xSMS1Jd4FOteeXjcivPOyxazH+ATGQBSc9Ni9+bu2UEhwlYMWYwLeW2s7csomwVL7jdZh0
        JMpR6vhniNkCu3/YOwmYc+2thg9CIpaQhvk1wzdrg54Fslc0FSuxwf2gaFUZ7DMHlBNRmFo5iaDVK
        EMtVttrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFGtC-006Du3-Nh; Wed, 02 Feb 2022 14:45:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53D3A984C61; Wed,  2 Feb 2022 15:45:42 +0100 (CET)
Date:   Wed, 2 Feb 2022 15:45:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking: add missing __sched attributes
Message-ID: <20220202144542.GC20638@worktop.programming.kicks-ass.net>
References: <20220115231657.84828-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115231657.84828-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 03:16:57PM -0800, Minchan Kim wrote:
> This patch adds __sched attributes to a few missing places
> to show blocked function rather than locking function
> in get_wchan.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Thanks!
