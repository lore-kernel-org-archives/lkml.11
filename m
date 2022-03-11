Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68258C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 20:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiCKUxw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 15:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiCKUws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:52:48 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3881FA1F5;
        Fri, 11 Mar 2022 12:51:39 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8AC4E2C0;
        Fri, 11 Mar 2022 20:51:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8AC4E2C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1647031899; bh=/LWRPTtf700K3c+bDqiBvuFXKGiKGvDoktO+eG0ZbOM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pDiP0i/pTI7bWgXP9BQ4WB1HAtdoz/EVI82QH12SD12si2DJwo+sDctnZLy1ArFiL
         sk4wqhWxbpIlNTPNJa3U1EGoYhOpOBea8mEEO+9wrZCRUblTwt1h3FghSll8KYlYSm
         qeozLQ8ENK8DXYYmR2wph2E7z4yn52PmtqnCt7RCcoXe9rXknicVCLUhUAqessmqpv
         mSoaL6wkR2XxLsHs5rUhNGq0+VlbLGFL6wV8M74tJ+soyVo/l4MLpYe7o9lAB9Zbrz
         OvjTV2gwcvk5HVeAlcgsxDNEnYE6CE3y7dTnaITIJmKpvCeG5akqOqOK7b0e3BOiu2
         bZHsPfH7XfzIw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     kernel@axis.com, Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: UML: Mention telnetd for port channel
In-Reply-To: <20220310124230.3069354-1-vincent.whitchurch@axis.com>
References: <20220310124230.3069354-1-vincent.whitchurch@axis.com>
Date:   Fri, 11 Mar 2022 13:51:38 -0700
Message-ID: <87r1782ox1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Whitchurch <vincent.whitchurch@axis.com> writes:

> It is not obvious from the documentation that using the "port" channel
> for the console requires telnetd to be installed (see port_connection()
> in arch/um/drivers/port_user.c).  Mention this, and the fact that UML
> will not boot until a client connects.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  Documentation/virt/uml/user_mode_linux_howto_v2.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 2cafd3c3c6cb..d5ad96c795f6 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -664,7 +664,11 @@ one is input, the second one output.
>  * The fd channel - use file descriptor numbers for input/output. Example:
>    ``con1=fd:0,fd:1.``
>  
> -* The port channel - listen on TCP port number. Example: ``con1=port:4321``
> +* The port channel - start a telnet server on TCP port number. Example:
> +  ``con1=port:4321``.  The host must have /usr/sbin/in.telnetd (usually part of
> +  a telnetd package) and the port-helper from the UML utilities (see the
> +  information for the xterm channel below).  UML will not boot until a client
> +  connects.

Applied, thanks.

jon
