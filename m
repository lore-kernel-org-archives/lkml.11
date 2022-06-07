Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDF0C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 15:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbiFGPjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245408AbiFGPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:39:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5FC25292
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:39:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2871061680
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068B5C385A5;
        Tue,  7 Jun 2022 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654616388;
        bh=Ik/OAVT6Fn01MkR8E4IFocJ0hSGK3ciFnvFhNt91FW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqqOpjWLog4Xk7j+Ni4gd234Clj/OneHYFMhdZo254lEiJd4BUFqomr4Z0QaAI59n
         TOO4vHIXrBXrIgyLJfEppFNlUqs3jNWBC3kJbkSqm3cTYCRn0dGxXM7lwkGj2L6X6d
         XKwhO11OxXi83K//VvYOUJGYIaZJaO0YS3RWSqFI=
Date:   Tue, 7 Jun 2022 17:39:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/1] comedi: ni_usb6501: fix transfer-buffer overflows
Message-ID: <Yp9xQeXfsJ+sP4WB@kroah.com>
References: <20220607134720.6343-1-xiaohuizhang@ruc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607134720.6343-1-xiaohuizhang@ruc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:47:20PM +0800, Xiaohui Zhang wrote:
> Similar to the handling of vmk80xx_alloc_usb_buffers in commit
> a23461c47482("comedi: vmk80xx: fix transfer-buffer overflows"),
> we thought a patch might be needed here as well.
> 
> The driver uses endpoint-sized USB transfer buffers but up until
> recently had no sanity checks on the sizes.
> 
> ---
> 
> Fix the typo in the last bit of the old patch which use the wrong
> endpoint to determine the size for usb_tx_buf.
> 
> Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
> ---

Please read the documentation links I sent you that say how to properly
document this.

Please do so and then you can submit a v3.

thanks,

greg k-h
