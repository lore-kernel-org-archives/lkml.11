Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 23:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiBYXMy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 18:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYXMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:12:52 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F241D6F51
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:12:19 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNjl4-004z6a-7C; Fri, 25 Feb 2022 23:12:18 +0000
Date:   Fri, 25 Feb 2022 23:12:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tracefs: Set the group ownership in apply_options()
 not parse_options()
Message-ID: <YhliUqSoyMEm5jws@zeniv-ca.linux.org.uk>
References: <20220225153426.1c4cab6b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225153426.1c4cab6b@gandalf.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 03:34:26PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Al Viro brought it to my attention that the dentries may not be filled
> when the parse_options() is called, causing the call to set_gid() to
> possibly crash. It should only be called if parse_options() succeeds
> totally anyway.
> 
> He suggested the logical place to do the update is in apply_options().

Feel free to slap my Acked-by on that variant...
