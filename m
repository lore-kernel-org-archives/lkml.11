Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C9FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 07:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiGHHTc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbiGHHTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:19:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B3E7B352;
        Fri,  8 Jul 2022 00:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29AB8B824EC;
        Fri,  8 Jul 2022 07:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595AAC341CB;
        Fri,  8 Jul 2022 07:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657264755;
        bh=IwOXh+OMWyRPtIQMt78YAlA6CfL3v4Df8DVeuy+JGiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emu/UZkqmtofzZX8+aGsZNPCfQdxt6Z3Kg0NWOQI+BbY9hdofm/QzobkwFcdnpwDh
         wQDbtP+ks5fc99VBN2ytY0qbGN5Ada1beMSLEHZmQvQHsG1cNJ3oD70nNufUF4fnZU
         5thBOK5q8WNAqEWXdkctXmOimwTKPqLqQ4CXFZS0=
Date:   Fri, 8 Jul 2022 09:19:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jozef Martiniak <jomajm@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>, Hangyu Hua <hbh25y@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gadgetfs: ep_io - wait until IRQ finishes
Message-ID: <YsfacfpE+h/GLTC4@kroah.com>
References: <20220708070645.6130-1-jomajm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708070645.6130-1-jomajm@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:06:44AM +0200, Jozef Martiniak wrote:
> after usb_ep_queue() if wait_for_completion_interruptible() is
> interrupted we need to wait until IRQ gets finished.
> 
> Otherwise complete() from epio_complete() can corrupt stack.
> 
> Signed-off-by: Jozef Martiniak <jomajm@gmail.com>

What commit id does this fix?

thanks,

greg k-h
