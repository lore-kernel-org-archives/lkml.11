Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BD7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 17:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348373AbiEJRsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 13:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241938AbiEJRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:48:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65B22C13FE
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:44:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652204685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/Hc0xBzi9qcoaDWgLQZwP9MQj6a0ovFYtpu2lUE0Gw=;
        b=cS0Hlic5blpLSoLhRbBtJdl5r7NhbsODIbqoMKIhLPZ+kV7RuNf6ZdEBHbMPBK39iSnuyy
        wO8Rxg++6CiQj3QEWJZLQc4C4TSlAmK1ctisxztbmh5SArIgHSoQs5ELWVts2Z1YJ54YaT
        AEUneTp0oTeeN0sGIOaePILTXFUIJNWT5q8b3ZxXAvAJcKw3GvzfONrKHX4n7GNs3HFXWL
        RMICnaQ8x4hZ8fTd1MNSK1FRf730XUgo1qo6tmEoYZd6k3mdHEEWnrA//MH4+BL4zGQkw1
        VqYlQtzPv4ttp8o65d/7p3cWwaSWj/OFpeocMcnxu3GuNq856cgac8F6/1MiHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652204685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/Hc0xBzi9qcoaDWgLQZwP9MQj6a0ovFYtpu2lUE0Gw=;
        b=J3+PlA10UEeWYsIFweAxknRwtegIrA2o2Ut3PPPgLSNJLhK8R1oFxMDL4BfMcrbtKSNTtw
        PGGLUXeO/uZqERCw==
To:     Thomas Pfaff <tpfaff@pcs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Remove pointless synchronize_irq() in
 uart_port_shutdown()
In-Reply-To: <4fe2d4a1-fc6a-c7fa-d884-5ebd01bebd3@pcs.com>
References: <4fe2d4a1-fc6a-c7fa-d884-5ebd01bebd3@pcs.com>
Date:   Tue, 10 May 2022 19:44:44 +0200
Message-ID: <87czglp9ir.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10 2022 at 15:54, Thomas Pfaff wrote:
> From: Thomas Pfaff <tpfaff@pcs.com>
>
> Calling synchronize_irq() after free_irq() is pointless, the context to
> the irq is already lost.
> It was noticed while creating the bugfix "genirq: Synchronize interrupt 
> thread startup".
>
> Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
