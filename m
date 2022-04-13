Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7766DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 11:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiDMLMl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 07:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiDMLMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:12:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C26F1EEF6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:10:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4BB97210E5;
        Wed, 13 Apr 2022 11:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649848211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TnjMOi49oXVnuLBg+KGKCIGKhdsWS++UdU2loy9fS74=;
        b=o/ZxoLJFCaq1Rm65/CEBZ9afZrccJ35uj0DGme3zbwxRdfm7okX8t9TsCPeQepfOSzMF03
        4jZy1NF5vasYuLRo8/suK0pCu4PyaalqJcKTfrDIBeHaMPlUohVd2PHBpeEhs1qVR73yCe
        FGaPvRVqnyvCbexl/Fv1lm6yBMpRb4g=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E5556A3B88;
        Wed, 13 Apr 2022 11:10:10 +0000 (UTC)
Date:   Wed, 13 Apr 2022 13:10:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk/index: Printk index feature documentation
Message-ID: <YlavkoJ01vFEuFkz@alley>
References: <20220405114829.31837-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405114829.31837-1-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 13:48:29, Petr Mladek wrote:
> Document the printk index feature. The primary motivation is to
> explain that it is not creating KABI from particular printk() calls.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>

JFYI, the patch has been committed into printk/linux.git,
branch for-5.19.

Best Regards,
Petr
