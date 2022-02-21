Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9DAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 17:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381525AbiBURO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:14:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381516AbiBUROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:14:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C43D2611D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:14:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17594613EA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70F9C340F1;
        Mon, 21 Feb 2022 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645463639;
        bh=9RKcPbXHhUVKJ2kqLtrL8qTir0JYgo1zSrHEZWkk8bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+l1N9HbfKWkOV6tQSGG+kyw1FkvT9FWUNSrZvz3YWbev6q6F+wNfdU5+Vd5swQ0y
         xzBExfATjDxe0DtKYQphNFxCGvs4gxzeSGHqIvD4kiDfkVFeJ/JW6pRtIDjb7qT61T
         /+3RDW3X7nl5iM/sAx49ch2zqkjxa1zZtqfVJ6jo=
Date:   Mon, 21 Feb 2022 18:13:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: r8188eu: remove 5 GHz channels from
 ch_freq_map
Message-ID: <YhPIVFmStJOMI0QZ@kroah.com>
References: <20220220154847.7521-1-straube.linux@gmail.com>
 <20220220154847.7521-2-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220154847.7521-2-straube.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 04:48:45PM +0100, Michael Straube wrote:
> This driver is for chips that operate only in the 2.4 GHz band.

How do we know that?

thanks,

greg k-h
