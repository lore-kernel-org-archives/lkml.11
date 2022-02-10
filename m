Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070DFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 13:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbiBJNjQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 08:39:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiBJNjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:39:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ECBE9D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:39:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 52EBC1F37B;
        Thu, 10 Feb 2022 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644500354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+8V8VSgknXTUqClYTaOc1PPZGxQ3agBFSK/RjCRxEMs=;
        b=iBRS9kLnfLPp8IcsQ/XlZTE1TR+K1W6xHfES8xi58ndlekEURYHAjgD7ylvG155zn7+PLj
        Xv8GKNJUEkM4cNcL30588Quovt0vfaN8sk0nbKmVtlJbPt3ozQLhlnblrUQdWEEJk+W1v4
        Dw0gpfEayCvjx/DToXroKnGiaS4LKTc=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 132A0A3B87;
        Thu, 10 Feb 2022 13:39:14 +0000 (UTC)
Date:   Thu, 10 Feb 2022 14:39:13 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 1/2] vsprintf: Fix potential unaligned access
Message-ID: <YgUVgX42gbahbBuc@alley>
References: <20220127181233.72910-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127181233.72910-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-01-27 20:12:32, Andy Shevchenko wrote:
> The %p4cc specifier in some cases might get an unaligned pointer.
> Due to this we need to make copy to local variable once to avoid
> potential crashes on some architectures due to improper access.
> 
> Fixes: af612e43de6d ("lib/vsprintf: Add support for printing V4L2 and DRM fourccs")
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Both patches have been committed into printk/linux.git,
branch for-5.18-vsprintf-fourcc-fixup .

Best Regards,
Petr
