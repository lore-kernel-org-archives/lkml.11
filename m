Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BDCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 04:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377247AbiDDE7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 00:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377210AbiDDE7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4863467C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 21:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57E156117C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219AAC2BBE4;
        Mon,  4 Apr 2022 04:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649048235;
        bh=x8qVNaEw4ZdqW0+FdOtmtku3TWe/fwSsecwRMmpPD0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PeT0rsQ5bIk9e5WjnzETFZLFhqWAfH8w1WkWONfdoZJ8itYw5Hkw8sNSIVkDbOAqP
         WssnADN1TjSASeyaozUiZ+FYgDWf8LuLUZAltzJsyTcoUGtig6pJT0VNTuH+tUtHwJ
         Il3leO36kUgU5uEB02etPll6E3yZqfkNTipVpJp8=
Date:   Mon, 4 Apr 2022 06:57:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, javier@javigon.com,
        arnd@arndb.de, will@kernel.org, axboe@kernel.dk,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v10 0/3] drivers: ddcci: add drivers for DDCCI
Message-ID: <Ykp6p0DPCLJcLxWI@kroah.com>
References: <20220403230850.2986-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403230850.2986-1-yusisamerican@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 04:08:48PM -0700, Yusuf Khan wrote:
> v10: Change patch title to "drivers: ddcci: add drivers for DDCCI
> and change" and change patch descriptions to add more detailed
> explanations of function.

As Randy points out, the subjects can not all be the same as obviously
the patches are not doing all the same thing.  Please read the kernel
documentation for how to write good subject lines and good changelog
texts.

thanks,

greg k-h
