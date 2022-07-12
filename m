Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C1DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 13:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiGLNoR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGLNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A83C1BE96;
        Tue, 12 Jul 2022 06:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2852617FE;
        Tue, 12 Jul 2022 13:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A813AC341C8;
        Tue, 12 Jul 2022 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657633431;
        bh=Qb/oUeQurbQ9x0BxaRhTtPoP0Rue+w9iCNr3XC122bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKJm9saZQJLyT7txlacfxKQhiRYO2mgMqWSMoSF4rBGk2U2eLzJt/dPWBYiN//8uE
         mE8YiOrmiTYxuOJj2Yy9pr7naWd8pWnDtQMNn3RSKZY1cp2HioL4/5oHbOa2G+aCsm
         H7ytYiR8Pj9r9Az3wxx/jAkJyNZvOa1GrZBxTy1g=
Date:   Tue, 12 Jul 2022 15:43:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Xin Ji <xji@analogixsemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v16 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Message-ID: <Ys16lEvhVSSSRMP7@kroah.com>
References: <20220712090534.2783494-1-xji@analogixsemi.com>
 <0bd85140-f006-8b29-0a43-500733f1654c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd85140-f006-8b29-0a43-500733f1654c@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 06:31:22AM -0700, Guenter Roeck wrote:
> On 7/12/22 02:05, Xin Ji wrote:
> > USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> > and a port controller (TCPC) - may require that the driver for the PD
> > controller accesses directly also the on-chip port controller in some cases.
> > 
> > Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > 
> > ---
> > V9 -> V10: Rebase on the latest code
> > V8 -> V9 : Add more commit message
> > V7 -> V8 : Fix Guanter's comment, remove unnecessary explain
> 
> We are now at v16. The change log has not been updated since v10,
> making it all but worthless.

It's also already in my tree for a while, so I have no idea what this is
being generated against :(

