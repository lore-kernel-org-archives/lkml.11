Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 14:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbiEIOSj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 10:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbiEIOSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:18:36 -0400
X-Greylist: delayed 454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 07:14:42 PDT
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEA922D60E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:14:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id A4D7620194;
        Mon,  9 May 2022 16:07:06 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tYlx5t2-NAqj; Mon,  9 May 2022 16:07:06 +0200 (CEST)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 48AFA20180;
        Mon,  9 May 2022 16:07:06 +0200 (CEST)
Received: from samy by begin with local (Exim 4.95)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1no42T-002SDR-LT;
        Mon, 09 May 2022 16:07:05 +0200
Date:   Mon, 9 May 2022 16:07:05 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCHv2] speakup: Generate speakupmap.h automatically
Message-ID: <20220509140705.n3eei4r5ko6bbex4@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20220430003934.fkua7vwoz6heigrp@begin>
 <20220430073321.6b4lvrrt7buzh7dp@begin>
 <YnkfeyobcOOgDGkH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnkfeyobcOOgDGkH@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Greg KH, le lun. 09 mai 2022 16:04:43 +0200, a ecrit:
> Any reason you can't add the code in utils.c into genmap.c and then
> merge into makemapdata.c to make this a single .c file that does both
> things?

Yes: genmap is a tool that end-users can use without needing the Linux
source code, while makemapdata needs it.

> And when this is applied, I get the following "extra" files in the tree
> that need to be properly ignored, so I couldn't take this as-is anyway:

Oh, right, I'll fix them.

Samuel
