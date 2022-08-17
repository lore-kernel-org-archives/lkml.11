Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA95C25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 06:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiHQGRS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiHQGRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:17:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A0F6BD78;
        Tue, 16 Aug 2022 23:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3D66B81AD5;
        Wed, 17 Aug 2022 06:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E081FC433C1;
        Wed, 17 Aug 2022 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660717032;
        bh=6Bd9BwXv3tuxo+nCXxTfzSiPGFvv5j2FzFiQrqXb21M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q0e+QbBghBjKvmTa1lUwUZNyqC6Gs3b82roBOnMEUfnzA7tXt1JOTdAue8pIPIsUK
         qKUYD24Ygq7WUeNr6wnlcJDd+96OLfNyAAdBR9Nk9uVMXIFwHbHh91uk3yT2hm+zNI
         qla+HwY4Hd7L9Bc1+/nOiDZ7EEQP6l/lPF7DZP54=
Date:   Wed, 17 Aug 2022 08:17:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thierry Guibert <thierry.guibert@croix-rouge.fr>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com
Subject: Re: [PATCH] CDC-ACM : Add Icom PMR F3400 support (0c26:0020)
Message-ID: <YvyH5JqFtm1pOcid@kroah.com>
References: <CAEzRux_E+EAEkdr8RVGq4BTJ87G75fwXf4gveLTmk_P3nxizvw@mail.gmail.com>
 <YvvDtUi7zgrYlopw@kroah.com>
 <CAEzRux-PG6Fe3qr1kmHqr-tbozmzkpOmM89UAXH-44BuYYcUpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzRux-PG6Fe3qr1kmHqr-tbozmzkpOmM89UAXH-44BuYYcUpA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 06:27:24PM +0200, Thierry Guibert wrote:
> Hi Greg,
> 
> I use « git format-patch -1 <commit SHA>[[ » to build a .patch file, and I
> have to use the Gmail web GUI to send it since we have no more access to
> local clients.

You can not use the gmail web gui to send out patches, sorry, that does
not work as it will corrupt it.

thanks,

greg k-h
