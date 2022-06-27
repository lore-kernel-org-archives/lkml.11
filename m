Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63430C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiF0LIB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiF0LH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F01164D3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B15F2613F9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9493EC3411D;
        Mon, 27 Jun 2022 11:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656328078;
        bh=haxHAjRpU+/6mmZExs2SLPmWmGf4m9w9TRXkoNQuhUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eppB2M+eor9/IjlnMPrkfJlJ84xF7uPrdwdJL3tBmsDaoxemYE6FCre4vfDFWpDkO
         VmIYZ4WOc30sfcUoagZ6jZBq/qtAhMdYBy9Oz77bBFQoytE38AVltbeFWCn+wF2cg1
         3Axb+k5TRIAe6oiJgo33F71ULPNPpVTOqAFpdu8E=
Date:   Mon, 27 Jun 2022 13:07:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yangxi Xiang <xyangxi5@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH] vt: fix memory overlapping when deleting chars in the
 buffer
Message-ID: <YrmPi/D4dZAySgll@kroah.com>
References: <YrmKvSFSvPpT7Q3O@kroah.com>
 <20220627110417.27648-1-xyangxi5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627110417.27648-1-xyangxi5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 07:04:17PM +0800, Yangxi Xiang wrote:
> > What commit does this fix?  how was this tested?
> 
> This bug is triggered by running a dynamic analysis on the kernel,
> with the help of sanitizer to observe this bug. This memory
> overlapping copy can cause data corruption when scr_memcpyw is
> optimized to memcpy because memcpy does not ensure its behavior if
> the destination buffer overlaps with the source buffer.

And what commit id does this fix, or has it always been broken?

thanks,

greg k-h
