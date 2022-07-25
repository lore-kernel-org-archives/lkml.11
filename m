Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02A9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 08:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiGYIyD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 04:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiGYIyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA6814D2D;
        Mon, 25 Jul 2022 01:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1D406120C;
        Mon, 25 Jul 2022 08:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513D6C341C7;
        Mon, 25 Jul 2022 08:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658739239;
        bh=27gvfS9RG9a5z0+nFk0qGSBheVBUDJc370UKyXlr5xA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjIrW/mHVmWz8V0e8D+Io/5M9O3TYRAWiBz0BeVDcuyhOKAj1mtYv4JIZTRAQW9mE
         ikYrgXH0g3gZ/wAN8xui9tQkl/rprJCjtEcfVU7uyIvGyMPo8o14xLooGSvxe/xamD
         qm8A5Glm9XGLNTMEEeSfXBSnrGw8AIbvmaC3cad4=
Date:   Mon, 25 Jul 2022 10:53:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: fix tty-port initialized comments
Message-ID: <Yt5aIiA8mvU905eB@kroah.com>
References: <20220725084457.3010-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725084457.3010-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:44:57AM +0200, Johan Hovold wrote:
> Fix up the tty-port initialized comments which got truncated and
> obfuscated when replacing the old ASYNCB_INITIALIZED flag.
> 
> Fixes: d41861ca19c9 ("tty: Replace ASYNC_INITIALIZED bit and update atomically")
> Signed-off-by: Johan Hovold <johan@kernel.org>

Looks good, want me to take this now as my tree should be "closed" for
5.20-rc1 now, but stuff like this can sneak in.

If not, and you want to send it to me later, feel free to add:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
