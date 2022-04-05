Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E17C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1844873AbiDFBxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446287AbiDEPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:44:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B4276
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF968B81B18
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2232DC385A0;
        Tue,  5 Apr 2022 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649168012;
        bh=J7HCJkshX2Pc5q0J6hzinjXyY0BZxW6N/Kloo4Faflw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q818vD8EN3d0ohROvuHYNbX5wg5mBo3+SNJYfrLXDUMPJEIsF8m6Z2zx0VRl3Ug5j
         WYIHW8s6fVfSYDRGQ+ouV2E9HrcNo8IKE/fDexSNNURqfwv/qdrmSRFUr3CjPPXcHM
         JOoN0gx17uUW/c8jel0J8DCfjezHp/IJnTb94ObA=
Date:   Tue, 5 Apr 2022 16:13:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: r8188eu: drop redundant if check in
 check_fwstate
Message-ID: <YkxOitByai03u8Qc@kroah.com>
References: <20220405124239.3372-1-makvihas@gmail.com>
 <20220405124239.3372-3-makvihas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405124239.3372-3-makvihas@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 06:12:39PM +0530, Vihas Makwana wrote:
> The if check is redundant. Drop it and simplify the funciton.
> 
> Also, drop clr_fwstate(), clr_fwstate_ex(), up_scanned_network() and
> down_scanned_network() as they are not used anywhere.

When you write "also" in a changelog text, that's a huge hint that you
should break this up into multiple patches.

Remember, do only one logical thing per change.  This should be split up
into 2 patches.

thanks,

greg k-h
