Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93458C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 09:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347740AbiFJJBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 05:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244939AbiFJJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:01:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5094B212C82;
        Fri, 10 Jun 2022 02:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 099ECB832CB;
        Fri, 10 Jun 2022 09:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A87EC34114;
        Fri, 10 Jun 2022 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654851667;
        bh=fUOL3Ydks9k3rSvCoOT8c0eo7uVClb98PR2l6eqO//Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUo6m7IX2j1atBpivpFUxxlH0gU7Vk40IJRi70t8waR74t+UZwLZzWAgVXmGZPdYm
         o4Z0NYludwDEMHb3jbyVJNepvjOcLzRnQsijisTo+YA1r2asAWkxoBJ53HhEXLUCrr
         OaTDsbq0rNyt4becwKDzWgG+evOcrGXil4BOjlvM=
Date:   Fri, 10 Jun 2022 11:01:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yihao Han <hanyihao@vivo.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: phy: tahvo: Check before clk_disable() not needed
Message-ID: <YqMIUOTU/k5XpW3I@kroah.com>
References: <20220610074525.69453-1-hanyihao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610074525.69453-1-hanyihao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:45:25AM -0700, Yihao Han wrote:
> clk_disable() already checks the clk ptr using IS_ERR_OR_NULL(clk)

It does?  Are you sure?  It will check for NULL, that's it.

> so there is no need to check it again before calling it.

This will break on some platforms, please always test your patches
before sending them out.

thanks,

greg k-h
