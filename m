Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765E3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 06:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiDMG4q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 02:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiDMG4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DD425CF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A632761D09
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA4FC385A3;
        Wed, 13 Apr 2022 06:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649832856;
        bh=CbMgaxB/pZ/pmuqyPdSa2A9bsEC8vggjZGsYLDigH0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhOYn/cCzc2iN9KJdyyUYemUvXd+hCOrO5trCttEb7wJ0EZiVpIi7SvbABqIOahRh
         Q3PU9rLvoBwXVU1xQgjJnZRMFBKnMO9sHzLyLfSgeFUL5t0+lK4hpQXXAJhFAyoPbV
         xUTbDo/xiCzL0aDN9kJOTz2PsHnzH1J9cvWkAGs8=
Date:   Wed, 13 Apr 2022 08:54:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] staging: r8188eu: rename parameter of block_write()
Message-ID: <YlZzlRumS5KH7aih@kroah.com>
References: <20220412185754.8695-1-straube.linux@gmail.com>
 <20220412185754.8695-3-straube.linux@gmail.com>
 <YlZzeEOn6VC4Tmre@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlZzeEOn6VC4Tmre@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:53:44AM +0200, Greg KH wrote:
> On Tue, Apr 12, 2022 at 08:57:50PM +0200, Michael Straube wrote:
> > Rename the parameter buffSize of block_write() to avoid camel case.
> > 
> > buffSize -> size
> 
> How about "buffSize -> buffer_size"?
> 
> That makes more sense, right?

Ah nevermind, it's fine as-is.

