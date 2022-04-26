Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F6DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 14:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351476AbiDZOOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 10:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351473AbiDZOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:14:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA83A183A7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FE35B81F53
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30C4C385AC;
        Tue, 26 Apr 2022 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650982291;
        bh=Nhzvp7jJarf28aGArWk3ZMIorlcsYtKlCn/06+G8pzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccdRPcUyI3PrRNcy1FhPbtsXi98ekMgWwajj8epoi2WsmTfkLSAYGrSW9ocLqQsDq
         Bbpf/M44EvPwiNPAjp0jEG3swNNLdKDsBwZkjo7qNGxlWve0L6uqKrg39fZnY8q829
         qn6mVWz+MxAX2jPQ7ljPaPATVB+dO9nQ4FZU6Q/Q=
Date:   Tue, 26 Apr 2022 16:11:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Noah Tschirner <noahtschirner@gmail.com>
Cc:     jerome.pouiller@silabs.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: wfx: Fixed a space coding style issue.
Message-ID: <Ymf9j8CQhSX8HNRT@kroah.com>
References: <20220426135148.29785-1-noahtschirner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426135148.29785-1-noahtschirner@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:51:48PM +0200, Noah Tschirner wrote:
> Fixed a space coding style issue.
> 
> Signed-off-by: Noah Tschirner <noahtschirner@gmail.com>
> ---
>  drivers/staging/wfx/main.c | 2 +-

This is not a file in the linux-next tree.

Always work off of either linux-next, or the subsystem-specific git tree
so you do not duplicate work that others have done.

thanks,

greg k-h
