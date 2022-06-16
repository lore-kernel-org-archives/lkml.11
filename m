Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B015AC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 06:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359194AbiFPGbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 02:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359124AbiFPGbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:31:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1B56B26
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:31:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4440468AA6; Thu, 16 Jun 2022 08:31:04 +0200 (CEST)
Date:   Thu, 16 Jun 2022 08:31:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hans =?iso-8859-1?Q?M=FCller?= <schreibemirhalt@gmail.com>,
        arve@android.com, christian@brauner.io, hch@lst.de,
        hridya@google.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, maco@android.com,
        surenb@google.com, tkjos@android.com
Subject: Re: [PATCH] staging: remove ashmem
Message-ID: <20220616063104.GA5494@lst.de>
References: <YjCTL/2ZJW8EWLHL@kroah.com> <3f8d25aa-17a6-e6aa-4b6d-d3388ef35201@gmail.com> <YqrN38V/qS9ljk8+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqrN38V/qS9ljk8+@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 08:29:51AM +0200, Greg KH wrote:
> That is a "Android 7-based" system?  That's old, how are they supporting
> that anymore with the security stuff that has happened since then?
> 
> Anyway, if this were to come back, I need a maintainer who agrees to
> maintain it and fix and support it.  Are you able to do that?  If so, I
> think it would probably be easier to fix up anbox to use memfd instead,
> is anyone doing that (I couldn't figure that out from the github
> issue...)

I'm very much against this.  ashmem is a mess and we should not maintain
it for some kind of retro computing group.
