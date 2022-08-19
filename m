Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C86C25B0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 07:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346993AbiHSHGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 03:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346847AbiHSHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:06:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE9AE1933
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19BD2615FB
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21ABFC433D6;
        Fri, 19 Aug 2022 07:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660892795;
        bh=cp+vyEMTbv7YFDOX3ot15HLf44wWAWu4Pm5/zW002lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdQnZ8kL1yciTjvliLlzLOGtXUUsCjz29FI3MhGF4VUTfa1x/N4Fg3jqxRS1ZL1EF
         Eani4mUsiDzs54ksizqaDBqcUg4flri5rpCfr80Gv8IIoGWHdqMNrcInzbcBLLdj8J
         8Pk/IscJbXNF1KX1PXVLgVVnuX48EWdZdvzS+YI4=
Date:   Fri, 19 Aug 2022 09:06:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhishek Shah <abhishek.shah@columbia.edu>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        bjohannesmeyer@gmail.com, jakobkoschel@gmail.com,
        xiam0nd.tong@gmail.com, Gabriel Ryan <gabe@cs.columbia.edu>
Subject: Re: data-race in set_console / vt_ioctl
Message-ID: <Yv82cwVT9MXX2nx/@kroah.com>
References: <CAEHB249P1XurGDtvfjzkEzP4qWEaL6FG4ENM=PYjk7-JZfnKrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEHB249P1XurGDtvfjzkEzP4qWEaL6FG4ENM=PYjk7-JZfnKrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 09:17:00PM -0400, Abhishek Shah wrote:
> Hi all,
> 
> We found a data race involving the *vt_dont_switch* variable. Upon further
> investigation, we see that this racing variable controls whether the
> callbacks will be scheduled in the console (see here
> <https://elixir.bootlin.com/linux/v5.18-rc5/source/drivers/tty/vt/vt.c#L3032>),
> but we are not sure of its security implications. Please let us know what
> you think.

Again, any patch that you might have to resolve this would be great, as
that's the easiest thing to review.

thanks,

greg k-h
