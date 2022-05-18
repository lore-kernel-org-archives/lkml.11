Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05FDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 08:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiERIrP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 04:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiERIrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:47:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955651339FC
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 029D7B81ED4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8FEC385A5;
        Wed, 18 May 2022 08:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652863629;
        bh=vr/nPTFeoLJC+tT+5tctwdW2kiBxX5Fon860iDKi32c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMgOwsGUsb3ZButiya1AHhAw0UFJnfrusAILwGrqeRsAYZrciI8tpx/3IjzEmLWJY
         /g+7SXGV7jMbbI7IwyX0Qe6EhTvRplKzj3RFUDG7JHzEGWjqVJwj5BXMyW6MJqMrBq
         p9Dr2EGtk2rGAfhfiixpqXaYiidSUvTOMmYjulpk=
Date:   Wed, 18 May 2022 10:47:06 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uio: reset file private_data pointer after kfree
Message-ID: <YoSyimczp9+oUoxv@kroah.com>
References: <HK2PR06MB3554789EC96D408ADDDC82F8E3D19@HK2PR06MB3554.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK2PR06MB3554789EC96D408ADDDC82F8E3D19@HK2PR06MB3554.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 04:16:40AM +0000, 王文虎 wrote:
> ________________________________
> 
> 本邮件及其附件内容可能含有机密和/或隐私信息，仅供指定个人或机构使用。若您非发件人指定收件人或其代理人，请勿使用、传播、复制或存储此邮件之任何内容或其附件。如您误收本邮件，请即以回复或电话方式通知发件人，并将原始邮件、附件及其所有复本删除。谢谢。
> The contents of this message and any attachments may contain confidential and/or privileged information and are intended exclusively for the addressee(s). If you are not the intended recipient of this message or their agent, please note that any use, dissemination, copying, or storage of this message or its attachments is not allowed. If you receive this message in error, please notify the sender by reply the message or phone and delete this message, any attachments and any copies immediately.
> Thank you

Now deleted.
