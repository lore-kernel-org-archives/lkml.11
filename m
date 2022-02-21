Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D31C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 15:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378986AbiBUPTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 10:19:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbiBUPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:19:00 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13BC1DA73;
        Mon, 21 Feb 2022 07:18:37 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMASS-003dgP-QE; Mon, 21 Feb 2022 15:18:36 +0000
Date:   Mon, 21 Feb 2022 15:18:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] lib/iov_iter: initialize "flags" in new pipe_buffer
Message-ID: <YhOtTAj1CTRWlbRo@zeniv-ca.linux.org.uk>
References: <20220221100313.1504449-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221100313.1504449-1-max.kellermann@ionos.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:03:13AM +0100, Max Kellermann wrote:
> The functions copy_page_to_iter_pipe() and push_pipe() can both
> allocate a new pipe_buffer, but the "flags" member initializer is
> missing.
> 
> Fixes: 241699cd72a8 ("new iov_iter flavour: pipe-backed")
> To: Alexander Viro <viro@zeniv.linux.org.uk>
> To: linux-fsdevel@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Applied, will push to Linus...
