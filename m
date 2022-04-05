Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79706C4167D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582468AbiDEXn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 19:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446222AbiDEPoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:44:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B212AA9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1278E60919
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE8CC385A1;
        Tue,  5 Apr 2022 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649167927;
        bh=vH0lA9xexLl2Q4ZuTZMoUwtmOPngDKTGoM1yj3E7AVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PoOoCd+d0WwbV6Jw0bdOraI2w+PW3nl4cD7gFp54G3bjCCn96k4o+YouLinO4gfWk
         N58RCT+ZEKDXRAhBk3qUOAd4KVPJGV9vRrlqsRRIfxiw+Q8nPB4XnfH3uEu5k9zMre
         kPbSzlsFu4WExW6lobHz/ID1hNbbjndmzB5itutk=
Date:   Tue, 5 Apr 2022 16:11:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] staging: r8188eu: remove GetHalDefVar8188EUsb()
Message-ID: <YkxOJ1YEEke2jcmM@kroah.com>
References: <20220405104910.9769-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405104910.9769-1-straube.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 12:49:06PM +0200, Michael Straube wrote:
> This series removes the function GetHalDefVar8188EUsb(). This is part
> of the ongoing effort to get rid of the unwanted hal layer.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> v2:
> - remove dead code first
> - use better function names
> - make one function static
> 

Thanks for the changes, now queued up.

greg k-h
