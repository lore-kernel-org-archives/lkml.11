Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ECBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jan 2022 23:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbiAJXvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jan 2022 18:51:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43034 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242563AbiAJXvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:51:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2514C61499
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 23:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B622C36AE5;
        Mon, 10 Jan 2022 23:51:02 +0000 (UTC)
Date:   Mon, 10 Jan 2022 18:51:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING: modpost: vmlinux.o(.text.unlikely+0x2c44): Section
 mismatch in reference from the function trace_define_generic_fields() to
 the variable .init.data:initcall_level_names
Message-ID: <20220110185100.6c4c226c@gandalf.local.home>
In-Reply-To: <202112210114.CFpCHRci-lkp@intel.com>
References: <202112210114.CFpCHRci-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 01:12:12 +0800
kernel test robot <lkp@intel.com> wrote:

> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: vmlinux.o(.text.unlikely+0x2c44): Section mismatch in reference from the function trace_define_generic_fields() to the variable .init.data:initcall_level_names  
> The function trace_define_generic_fields() references
> the variable __initdata initcall_level_names.
> This is often because trace_define_generic_fields lacks a __initdata
> annotation or the annotation of initcall_level_names is wrong.

I keep getting this, and it looks like a bug in the compiler not the kernel
code.

We have:

int filter_assign_type(const char *type)
{
	if (strstr(type, "__data_loc") && strstr(type, "char"))
		return FILTER_DYN_STRING;

	if (strstr(type, "__rel_loc") && strstr(type, "char"))
		return FILTER_RDYN_STRING;

	if (strchr(type, '[') && strstr(type, "char"))
		return FILTER_STATIC_STRING;

	if (strcmp(type, "char *") == 0 || strcmp(type, "const char *") == 0)
		return FILTER_PTR_STRING;

	return FILTER_OTHER;
}

static int __trace_define_field(struct list_head *head, const char *type,
				const char *name, int offset, int size,
				int is_signed, int filter_type)
{
	struct ftrace_event_field *field;

	field = kmem_cache_alloc(field_cachep, GFP_TRACE);
	if (!field)
		return -ENOMEM;

	field->name = name;
	field->type = type;

	if (filter_type == FILTER_OTHER)
		field->filter_type = filter_assign_type(type);
	else
		field->filter_type = filter_type;

	field->offset = offset;
	field->size = size;
	field->is_signed = is_signed;

	list_add(&field->link, head);

	return 0;
}

#define is_signed_type(type)	(((type)(-1)) < (type)1)

static LIST_HEAD(ftrace_generic_fields);

#define __generic_field(type, item, filter_type)			\
	ret = __trace_define_field(&ftrace_generic_fields, #type,	\
				   #item, 0, 0, is_signed_type(type),	\
				   filter_type);			\
	if (ret)							\
		return ret;


static int trace_define_generic_fields(void)
{
	int ret;

	__generic_field(int, CPU, FILTER_CPU);
	__generic_field(int, cpu, FILTER_CPU);
	__generic_field(char *, COMM, FILTER_COMM);
	__generic_field(char *, comm, FILTER_COMM);

	return ret;
}


Please tell me where initcall_level_names is being referenced?

Either fix the compiler or tell me exactly what the bug is. Otherwise, stop
sending me this.

-- Steve
