Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B96C43217
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588318AbiDFAPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445553AbiDEPnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:43:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2EBDCE24
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EB09B81DFA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C8CC385A9;
        Tue,  5 Apr 2022 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649167754;
        bh=Wcg3ZHMdsCB1wYGU2/I4aiT0HZnWfz1uNuRzGLaMoxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkZlKhsCTiQ5hiJ8/WlYtPAIIuU2uYjk/UDJhMugG2KAsSYMPU21MYPAqXYBLLcDM
         YW2lzXc2oMbNzFJfxZsk/byWUQrgHDAmtxUnpWVDy3NaltKniRopGYfhy2m2pe3xIm
         1HVxT/9DX6a36erzCur5luxmyDq/ffGLzWwb/g6w=
Date:   Tue, 5 Apr 2022 16:09:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] staging: vt6655: Rename macro arguments with
 CamelCase
Message-ID: <YkxNiGT+kzYnbU69@kroah.com>
References: <cover.1649103348.git.philipp.g.hortmann@gmail.com>
 <70cce6671976e454830c12d6d7977a5fe816a287.1649103348.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70cce6671976e454830c12d6d7977a5fe816a287.1649103348.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 10:48:47PM +0200, Philipp Hortmann wrote:
> Rename macro arguments with CamelCase in upc.h as
> they are not accepted by checkpatch.pl
> Removed datatype in macro arguments.
> 
> Since there are more than one checkpatch issue per line,
> more steps are rquired to fix.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> V1 -> V2: This patch was 4/7 and is now 3/6
> ---
>  drivers/staging/vt6655/upc.h | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
> index b374db5fca81..f080a25e6cdf 100644
> --- a/drivers/staging/vt6655/upc.h
> +++ b/drivers/staging/vt6655/upc.h
> @@ -20,34 +20,34 @@
>  
>  /* For memory mapped IO */
>  
> -#define VNSvInPortB(dwIOAddress, pbyData) \
> -	(*(pbyData) = ioread8(dwIOAddress))
> +#define VNSvInPortB(io_address, data) \
> +	(*(data) = ioread8(io_address))

These should all just go away, don't spend time cleaning them up.

Replace the callers with the ioread* calls instead.  Should be one patch
per macro to remove.

thanks,

greg k-h
