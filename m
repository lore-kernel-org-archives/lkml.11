Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340A2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 12:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiF0Mel (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiF0Mei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:34:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA69BE0F;
        Mon, 27 Jun 2022 05:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A361B81256;
        Mon, 27 Jun 2022 12:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEF8C3411D;
        Mon, 27 Jun 2022 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656333274;
        bh=AkgkDxG27313pmEXu7TC66xuMD9qpbnCbpt40zlJWL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g1XtPj+TUQRORFle2pWYiA6PKlTmCjC7b4XuIetzYHoaNUe0KF0e+RhGJQfAgYZhI
         KCnSKexvGVr9aZmUem0r6+mw7dPVQ47J2Npp+5inaTG1eU7Is2agikpRYWCtOc+5iw
         QAZAXLHMIz/2Zs0CYBIGuKqy4WdlSz/gzQ3Up6Dg=
Date:   Mon, 27 Jun 2022 14:34:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: tty: add closing double backticks for
 lookahead_buf() prototype
Message-ID: <Yrmj14W7eOyuTS94@kroah.com>
References: <20220614164745.7b746354@canb.auug.org.au>
 <20220614091214.511791-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220614091214.511791-1-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 04:12:15PM +0700, Bagas Sanjaya wrote:
> After merging tty tree for linux-next testing, Stephen Rothwell reported
> htmldocs warning:
> 
> Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: WARNING: Inline literal start-string without end-string.
> Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: WARNING: Inline emphasis start-string without end-string.
> Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: WARNING: Inline emphasis start-string without end-string.
> Documentation/driver-api/tty/tty_ldisc:46: include/linux/tty_ldisc.h:190: WARNING: Inline emphasis start-string without end-string.
> 
> The warning is because of missing closing double backticks at
> lookahead_buf() function prototype ([DRV] directive), which cause the
> prototype to be rendered as normal paragraph text instead of inline code
> (monospace).
> 
> Fix the warning by adding missing closing backticks.
> 
> Link: https://lore.kernel.org/linux-next/20220614164745.7b746354@canb.auug.org.au/
> Fixes: 6bb6fa6908ebd3 ("tty: Implement lookahead to process XON/XOFF timely")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  This patch is based on next-20220614.

Ilpo's patch was sent before yours, so I took theirs, sorry.

greg k-h
