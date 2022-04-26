Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DBFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 16:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353306AbiDZQys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 12:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353056AbiDZQxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:53:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C32DFAE58
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:48:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F739ED1;
        Tue, 26 Apr 2022 09:48:19 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C06B33F73B;
        Tue, 26 Apr 2022 09:48:18 -0700 (PDT)
Date:   Tue, 26 Apr 2022 17:48:16 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3] firmware: arm_scmi: support optee shared memory in
 optee transport
Message-ID: <YmgiQmeQSkglljEl@e120937-lin>
References: <20220425085127.2009-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425085127.2009-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:51:27AM +0200, Etienne Carriere wrote:
> Adds support for tee shared memory in optee scmi transport. When using
> tee shared memory, scmi optee transport manages SCMI messages using
> msg protocol (from msg.c) in shared memory, whereas smt (from shmem.c)
> protocol is used with static IOMEM shared buffers.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v2:
> - Select configuration switch ARM_SCMI_HAVE_MSG when
>   ARM_SCMI_TRANSPORT_OPTEE is enabled.
> - Don't consider tee_shm in invoke_process_smt_channel() since
>   this function now assumes TEE shared memory is not used for SMT
>   based channel.
> 
> Changes since v1:
> - Remove call to scmi_rx_callback() in scmi_optee_send_message().
> ---

LGTM

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

