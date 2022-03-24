Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E9FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 12:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350308AbiCXMxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiCXMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:53:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02597A9979
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2597B82372
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F174EC340EC;
        Thu, 24 Mar 2022 12:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648126300;
        bh=BPWWPLm4C3FBaUAzEwWGvWjFuM7EwnRoYv1SAZiL9Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wIPSzPOG5UpXnCsoNOrRAsuFkCIsK19No1+qbNuqn6z/jqDelGlH+vuG91DWA0xgY
         LviP9tBio77Ob0KL6JIIIuci/3/TV6aOEidPow0J+V6eYRrOgYDeKWLiAuYHvUeQuL
         E24W9Etssw0wis3LHvN20goZMTwWOVgYt3xkDg0Y=
Date:   Thu, 24 Mar 2022 13:51:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     dave@stgolabs.net, hdanton@sina.com, jaegeuk@google.com,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
        quic_aiquny@quicinc.com, will@kernel.org
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Message-ID: <YjxpWRP1v+dJIZZD@kroah.com>
References: <Yi73sVutB2w3zxbT@kroah.com>
 <20220322024958.24633-1-chenguanyou@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322024958.24633-1-chenguanyou@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:49:58AM +0800, chenguanyou wrote:
> > What ever happened with this testing?
> 
> > thanks,
> 
> > greg k-h
> 
> We updated android gki, monkey test mini patch.
> Link: https://cs.android.com/android/kernel/superproject/+/common-android12-5.10-2022-03:common/kernel/locking/rwsem.c;l=1290

I do not understand what this is supposed to tell me to do at all :(
